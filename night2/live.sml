datatype LambdaCalculus = Function of string * LambdaCalculus
			| Application of LambdaCalculus * LambdaCalculus
			| Variable of string

fun toString expression =
  case expression of
      Variable v => v
    | Function (x, y) => "(lambda " ^ x ^ ". " ^ toString y ^ ")"
    | Application (x, y) => toString x ^ " " ^ toString y

fun replace (expression, subexpression, replacement) =
  if expression = subexpression then replacement
  else case expression of
	   Variable v => Variable v
	 | Function (arg, body) => 
	   Function (arg, replace (body, subexpression, replacement))
	 | Application (func, arg) => 
	   Application (replace (func, subexpression, replacement),
			replace (arg, subexpression, replacement))

fun evaluate expression =
  case expression of
      Variable v => Variable v
    | Function (arg, body) => 
      Function (arg, evaluate body)
    | Application (func, arg) => 
      let
	  val evaluated_func = evaluate func
	  val evaluated_arg = evaluate arg
      in
	  case evaluated_func of
	      Variable v => Application (Variable v, evaluated_arg)
	    | Application a => Application (Application a, evaluated_arg)
	    | Function (arg, body) => 
	      evaluate (replace (body, Variable arg, evaluated_arg))
      end

val test_expression : LambdaCalculus = 
    (Application 
	 (Application 
	      (Function ("x", Function ("y", Variable "y")), Variable "a")
	 , Variable "b"))

val printout = toString (evaluate test_expression)

val omega = Function ("x", Application (Variable "x", Variable "x"))
