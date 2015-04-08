(*  Lambda Night 3 : The Simply Typed Lambda Calculus
 *  Visit http://lambda-nights.com for more tutorials
 * ~Nathan Burgers
 *)

(********************************************************)
(* Map						        *)
(* 						        *)
(* This is a simple, really inefficient list-based map  *)
(* implementation I cooked up in like 20 minutes. Gimme *)
(* a break guys. 				        *)
(********************************************************)
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
 
(*********************************************************)
(* Exceptions						 *)
(* 							 *)
(* You can declare exceptions like this, and use the 	 *)
(* keyword `raise` to, you guessed it, raise exceptions. *)
(*********************************************************)

(* Here's an exception constructor that takes a `string` *)
exception Wee_woo_wee_woo_code of string
				
(* We could use this exception like this:
 * `raise Wee_woo_wee_woo_code "orange"`
 *)

(****************************************************)
(* Night 3 Start				    *)
(* 						    *)
(* We'll start coding tonight with this as our base *)
(****************************************************)
datatype Expression = Variable of { name : string }
		    | Abstraction of { argument : string,
				       body : Expression }
		    | Application of { function : Expression,
				       argument : Expression }
