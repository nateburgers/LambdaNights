(*  Lambda Night 3 : The Simply Typed Lambda Calculus
 *  Visit http://lambda-nights.com for more tutorials
 * ~Nathan Burgers
 *)

(* To be provided to the students: *)
type 'a Map = (string * 'a) list
exception Not_found of string

fun map_make () = []

fun map_singleton (key, value) = [(key, value)]

fun map_insert (map, key, value) = (key, value) :: map

fun map_lookup (map, key) =
  case map of
      [] => 
      raise (Not_found key)
    | (key', value) :: tail => 
      if key = key' then value 
      else map_lookup (tail, key)

fun map_remove (map, key) =		      
  case map of
      [] =>
      raise (Not_found key)
    | (key', value) :: tail => 
      if key = key' then tail
      else (key', value) :: (map_remove (tail, key))
(* End *)

datatype Type = IntegerType
	      | FunctionType of Type * Type
exception Type_check 

fun type_to_string t =
  case t of
      IntegerType => "Integer"
    | FunctionType (FunctionType (a, b), c) => 
      "(" ^ type_to_string a ^ " -> " ^ type_to_string b ^ ")" ^
      " -> " ^ type_to_string c
    | FunctionType (a, b) => 
      type_to_string a ^ " -> " ^ type_to_string b

datatype Expression = Abstraction of { argument : string,
				       argument_type : Type,
				       body : Expression }
		    | Application of { applicant : Expression,
				       applicand : Expression }
		    | Addition of { augend : Expression,
				    addend : Expression }
		    | Variable of string
		    | Integer of int

fun type_check (context : Type Map, expression : Expression) : Type =
  case expression of
      Abstraction { argument, argument_type, body } =>
      let
	  val body_context = map_insert (context, argument, argument_type)
	  val body_type = type_check (body_context, body)
      in
	  FunctionType (argument_type, body_type)
      end
   | Application { applicant, applicand } => 
     let
	 val applicant_type = type_check (context, applicant)
	 val applicand_type = type_check (context, applicand)
     in
	 case applicant_type of
	     FunctionType (argument_type, body_type) =>
	     if argument_type = applicand_type then body_type
	     else raise Type_check
	   | _ => raise Type_check
     end
   | Addition { augend, addend } => 
     let
	 val augend_type = type_check (context, augend)
	 val addend_type = type_check (context, addend)
     in
	 if augend_type = IntegerType andalso 
	    addend_type = IntegerType 
	 then IntegerType
	 else raise Type_check
     end						    
   | Variable name => map_lookup (context, name)
   | Integer _ => IntegerType

fun type_check_to_string (context, expression) =		      
  type_to_string (type_check (context, expression))
  handle Not_found name => "Error: Variable `" ^ name ^ "` Not Found"
       | Type_check => "Error: Invalid Type"

val free_variable = Variable "x"
val free_variable_type = type_check_to_string (map_make(), Variable "x")

val test_expression = 
    Abstraction { argument = "x",
		  argument_type = FunctionType (IntegerType, IntegerType),
		  body = Application { applicant = Variable "x",
				       applicand = Integer 3 }
		}

val test_expression_type = type_check_to_string (map_make (), test_expression)

fun replace (expression, subexpression, replacement) =
  if expression = subexpression then replacement
  else case expression of
	   Abstraction { argument, argument_type, body } =>
	   Abstraction { argument = argument, 
			 argument_type = argument_type,
			 body = replace (body, subexpression, replacement) }
	 | Application { applicant, applicand } => 
	   Application { applicant = replace (applicant, subexpression, replacement),
			 applicand = replace (applicand, subexpression, replacement) }
	 | Addition { augend, addend } =>
	   Addition { augend = replace (augend, subexpression, replacement),
		      addend = replace (addend, subexpression, replacement) }
	 | Variable name => Variable name
	 | Integer integer => Integer integer

exception Evaluate
fun evaluate expression = 
  case expression of
      Abstraction { argument, argument_type, body } =>
      Abstraction { argument = argument, 
		    argument_type = argument_type, 
		    body = body }
    | Application { applicand, applicant } => 
      let 
	  val applicand' = evaluate applicand
	  val applicant' = evaluate applicant
      in
	  case applicant' of
	      Abstraction { argument, argument_type, body } =>
	      evaluate (replace (body, Variable argument, applicand'))
	    | _ =>  raise Evaluate
      end
    | Addition { addend, augend } => 
      let 
	  val addend' = evaluate addend
	  val augend' = evaluate augend
      in
	  case (addend', augend') of
	      (Integer n, Integer m) => Integer (n + m)
	    | _ => raise Evaluate
      end
    | Variable name => raise Evaluate
    | Integer n => Integer n
		       
val test_expression_evaluated = 
    let 
	val expression = Application { applicant = Abstraction { argument = "x",
								 argument_type = IntegerType,
								 body = Addition { augend = Variable "x",
										   addend = Integer 1 } },
				       applicand = Integer 3 }
						   
    in
	evaluate expression
    end


