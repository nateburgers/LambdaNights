(* Lambda Night 1 : Standard-ML
 * ~Nathan Burgers
 * 
 * Visit http://lambda-nights.com for more tutorials
 *)

(**********************************************************)
(* Comments						  *)
(* 							  *)
(* text inside opening and closing `(*` and `*)` symbols  *)
(* are code comments, and are ignored by Standard-ML 	  *)
(**********************************************************)

(* Comments are good documentation tools. *)

(* When you see `==> ... some text ...` at the end of 
 * a line, it means that `... some text ...` is what you
 * can expect ML to spit out when you enter the code on
 * that line.
 *)

(************************************************)
(* Expressions				        *)
(* 					        *)
(* Expressions are the basic building block of  *)
(* computation in almost any language, the same *)
(* is true for Standard-ML. 		        *)
(************************************************)

(* Expressions can be mathematical *)

2 + 2 ;				(* ==> val it = 4 : int *)

(* Or calls to functions *)

size ( "Hello World!" )	;	(* ==> val it = 12 : int *)

(* And function calls don't need parenthesis *)

size "Hello World!" ;		(* ==> val it = 12 : int *)

(*****************************************************)
(* Types					     *)
(* 						     *)
(* Every expression, value, and function 	     *)
(* in Standard-ML has a type. Types are		     *)
(* strong and static; meaning they cannnot	     *)
(* be made to act like other types, and cannot	     *)
(* change at runtime. We do not have type-casts	     *)
(* in ML. If you want to cast a type, you have to    *)
(* write a conversion function.			     *)
(* 						     *)
(* All of these features help to make ML's type	     *)
(* system very powerful. It is also very expressive, *)
(* but we'll see more of that later.		     *)
(*****************************************************)

(* Try typing these into your interpreter,
 * the word after the `:` is the type of 
 * the expression you just entered 
 *)

2 + 2 ;				(* ==> val it = 2 : int *)
"Hello World!" ;		(* ==> val it = "Hello World!" : string *)
	
(* NOTE: ML has a powerful feature called 'Type Inference'
 * that allows it to determine the type of anything you can
 * give it. You never have to tell ML the types of 
 * expressions, values, or functions (or anything you can  
 * express, really). 
 *
 * This doesn't mean you shouldn't explicitly declare the
 * types of your code, doing so can be very valuable 
 * documentation for other programmers.
 *)

(*********************************************************)
(* Values						 *)
(* 							 *)
(* When we have an expression that we want to 		 *)
(* re-use at some point later in the program,		 *)
(* we can use Values to give a name to the expression    *)
(*********************************************************)

val two = 1 + 1			(* ==> val two = 2 : int *)
val four = two + two		(* ==> val four = 4 : int *)
val message = 
    "Hello " ^ "World!"         (* ==> val message = "Hello World!" : string *)

(* We can also be explicit about the types of values *)

val two' : int = 1 + 1		(* ==> val two' = 2 : int *)
val four' : int = two + two	(* ==> val four' = 4 : int *)
val message' : string =
    "Hello " ^ "World!"		(* ==> val message' = "Hello World!" : string *)

(* NOTE: You can't trick ML's type system.
 * for instance, the code: `val trick : string = 1337`
 * would cause a compilation error. ML will tell you that
 * it found out that `1337` is an integer, and that your
 * declared type doesn't match the actual type of `trick`.
 *)

(***********************************************************)
(* Functions						   *)
(* 							   *)
(* In mathematics, if we want to write an equation 	   *)
(* that can be 'parameterized' by a value, we write 	   *)
(* a function such as `f(x) = x`, which is the identity	   *)
(* function. To write a function that doubles its	   *)
(* parameter in math, we might write `f(x) = 2 * x`. Since *)
(* it doesn't make sense to double a `string`, we might	   *)
(* say that the function `f` only takes in integers and    *)
(* spits out integers, and might write something like	   *)
(* `f : Integers -> Integers`. The syntax in ML is similar *)
(***********************************************************)

(* We can define the 'identity' function *)

fun id (x) = x

(* And can eliminate the parenthesis around the parameter *)

fun id' x = x

(* We can write a function that only works on integers *)

fun double x = 2 * x		(* ==> val double = fn : int -> int *)

(* And choose to be very explicit about its type *)

fun double' (x : int) : int = 2 * x (* ==> val double' = fn : int -> int *)

(* ML also has `if`-expressions for choosing different execution paths *)
(* Note that `~` means `negate` *)

fun absolute_value x = if x < 0 then ~x else x (* ==> val absolute_value = fn : int -> int *)

(* NOTE: ML uses the syntax `foo -> bar` to denote a function
 * parameterised by a value of type `foo`, that returns a value
 * of type `bar`.
 *
 * If we have a function that can operate on any type, ML 
* can figure it
 *)

(**************************************************************)
(* Pattern Matching					      *)
(* 							      *)
(* Sometimes in mathematics, we might want to write partial   *)
(* functions that return specific values for specific inputs. *)
(* We can do the same in ML.				      *)
(**************************************************************)

(* If we want to define a function that simulates an ice-cream
 * salesman, that takes the number of scoops as input, and 
 * tells the happy ice-cream recipient a message based on 
 * how many scoops they bought, then we can write something
 * like this *)

fun ice_creams number =		(* val ice_creams = fn : int -> string *)
  case number of
      0 => "No ice cream? Get out!"
    | 1 => "One scoop coming up!"
    | 2 => "Yeah! Two scoops on the way!"
    | other => if other < 0
	       then "You want negative ice cream???"
	       else "Whoa, that's too much ice cream"

fun boolean_to_string bool = 	(* val boolean_to_string = fn : bool -> string *)
  case bool of
      true => "True"
    | false => "False"

(* We can also use pattern-matching syntax in function
 * definitions without using `case ... of` *)

fun ice_creams' 0 = "No ice cream? Get out!"
  | ice_creams' 1 = "One scoop coming up!"
  | ice_creams' 2 = "Yeah! Two scoops on the way!"
  | ice_creams' other = if other < 0
			then "You want negative ice cream???"
			else "Whoa, that's too much ice cream"

fun boolean_to_string' true = "True"
  | boolean_to_string' false = "False"

(************************************************************)
(* Records						    *)
(* 							    *)
(* So far we've seen how to create functions in ML, but the *)
(* other major component of programming is creating	    *)
(* data structures. One way of creating composite data	    *)
(* structures in ML is through Records. Records are 	    *)
(* a set of label-value pairs that cannot change at	    *)
(* runtime. They are different from hash-maps as record	    *)
(* keys are not strings, but identifiers in ML.		    *)
(************************************************************)

(* Note that the type of a record strongly reflects
 * the structure of the record itself. *)

val origin = { x = 0, y = 0 } (* ==> val origin = { x = 0, y = 0 } : { x : int, y : int } *)

(* The order of the fields does not matter *)

val origin' = { y = 0, x = 0 } 	
(* ==> val origin' = { x = 0, y = 0 } : { x : int, y : int } *)

val are_the_same : bool = (origin = origin') 
(* ==> val are_the_same = true : bool *)

(* Records can have fields of different types *)

val date = { month = "March", day = 13, year = 2015 }
(* ==> val date = ... : { month : string, day : int, year : int } *)

(* We can access the elements of a record in this way *)

val date_month = #month date
val date_day = #day date
val date_year = #year date

(* Pattern-Matching also works on records *)

fun is_it_march	{ month, day, year } = 
  if month = "March" then true else false

(***********************************************************)
(* Tuples						   *)
(* 							   *)
(* Sometimes we want to create a composite data structure, *)
(* but the meaning is so obvious that we don't want to	   *)
(* bother giving each field a specific name. 		   *)
(* 							   *)
(* A typical example is multiple return-values. Whereas	   *)
(* most languages need special support for multiple	   *)
(* return values, in ML we can just return a tuple	   *)
(* containing everything we wanted to return.		   *)
(***********************************************************)

val origin'' = ( 0, 0 )		(* ==> val origin'' = (0,0) : int * int *)
		   
(* The type of a tuple are its component types separated by `*`'s *)

val date' = ("March", 13, 2015) (* ==> val date' = ... : string * int * int *)

(* We can access tuple elements by index, starting at inded 1 *)

val date_month' = #1 date'
val date_day' = #2 date'
val date_year' = #3 date'

(* Pattern matching also works on Tuples *)

fun is_it_march' (month, day, year) =
  if month = "March" then true else false


(************************************************************)
(* Data Types						    *)
(* 							    *)
(* Sometimes we might want to define a data structure	    *)
(* that can take on multiple different forms. For instance, *)
(* it would be nice if booleans were not a language feature *)
(* and could be defined by programmers. It turns out that   *)
(* is precisely the kind of thing that Data Types in ML	    *)
(* are good for.					    *)
(************************************************************)

(* The following code creates a new type called `MyBoolean`,
 * and 2 constructor functions named `MyTrue` and `MyFalse`
 * that take no arguments. (they are constant) *)

datatype MyBoolean = MyTrue | MyFalse

(* And we can create values of this type *)

val my_bool : MyBoolean = MyTrue

(* Constructors for data types can also be parameterised *)

datatype IntOrString = Int of int | String of string

val an_int : IntOrString = Int 4

val a_string : IntOrString = String "Hello World!"

(* Data Types themselves can be parameterised by another type *)

datatype 'a Pair = Pair of 'a * 'a

val an_int_pair : int Pair = Pair (2, 2)

val a_string_pair : string Pair = Pair ("Hello", "World!")

val a_bool_pair : MyBoolean Pair = Pair (MyTrue, MyFalse)

(* Pattern Matching works with Data Types *)

fun got_a_string (Int _) = false 
  | got_a_string (String _) = true
(* ==> val got_a_string = fn : IntOrString -> bool *)

(**********************************************************)
(* And that's the majority of what you need to know about *)
(* writing programs in ML. 				  *)
(* 							  *)
(* In another session we will cover			  *)
(* how to write packages that contain sets of related 	  *)
(* values, functions, and types.			  *)
(* 							  *)
(* ML also has exceptions much like Java or C++, but	  *)
(* we will cover those only as the need arises. 	  *)
(* This will be a project-driven workshop, so		  *)
(* from here on out we will learn about language	  *)
(* features as we need them to build our compiler.	  *)
(* 							  *)
(* Thanks, and see you soon.				  *)
(**********************************************************)
