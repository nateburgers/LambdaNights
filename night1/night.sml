(* Lambda Night 1 : Standard-ML
 * http://lambda-nights.com
 *)

(* Expressions *)

(* Types *)
	
(* Values  *)

(* Functions *)
fun double x = x * 2
val something = double 3

(* Pattern Matching *)
fun ice_creams number =
  case number of
      0 => "awww."
    | 1 => "yeah, single scoop."
    | 2 => "two scoops!"
    | _ => "whoa, too many scoops"

(* Records *)
val a_point = { x = 3, y = 3 }
val date = { month = "March"
	   , day = 13
	   , year = 2014
	   }

(* Tuples *)
val another_point = ( 3, 3 )
val date = ("March", 13, 2014)

(* Data Types *)
datatype Boolean = True | False
(* datatype 'a List = Empty  *)
(* 		 | List of 'a * ('a List) *)

(* val string_list : string List =  *)
(*     List ("a string", List ("another string", Empty)) *)

(* Signatures *)
signature LISTB =
sig
    datatype 'a t = Empty 
		  | List of 'a * 'a t
end

(* Structures *)
structure ListB : LISTB =
struct
datatype 'a t = Empty 
	      | List of 'a * 'a t
end

(* Functor *)
functor DoubleList ( structure ListB : LISTB ) =
struct
datatype ('a, 'b) t = DoubleList of 'a ListB.t * 'b ListB.t
end

signature FS = 
sig
    type file
    val makefile : string -> file
end

signature OS = 
sig
end

functor MakeAnOS ( structure FS : FS ) : OS =
struct
val startfile = FS.makefile "start"

end

structure Lambda = 
struct

datatype t = LambdaAbstraction of string * t
	   | LambdaApplication of t * t
	   | Variable of string

end
