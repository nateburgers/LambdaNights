(*  Lambda Night 2 : The Lambda Calculus
 *  Visit http://lambda-nights.com for more tutorials
 * ~Nathan Burgers
 *)

(*****************************************************************************)
(* The Lambda Calculus							     *)
(* 									     *)
(* Lambda Calculus is a way for us to think about computing in the abstract. *)
(* Some smart guy named Alonzo Church designed it in the 1950's, and it can  *)
(* do everything a computer can do, using only 3 ideas.			     *)
(* Those 3 ideas are: Function Definition, Function Calls, and Variables.    *)
(* That's right, in Lambda Calculus, we don't need or use numbers, just      *)
(* variables. It's called the Lambda Calculus because we use the symbol      *)
(* "lambda" to define functions, just like the "fun" keyword in ML.	     *)
(*****************************************************************************)

(*******************************************************************************)
(* Variables								       *)
(* 									       *)
(* Variables are usually one letter long, and look something like 	       *)
(* `x`, `y`, or `a` (minus the ``-tick-quotes). For instance, the following is *)
(* a valid program:							       *)
(* 									       *)
(*   x									       *)
(* 									       *)
(* Although it doesn't do very much. When we evaluate this program, we get     *)
(* back exactly what we put in: `x`. In Lambda Calculus, variables aren't      *)
(* assigned to values, they just kind of exist.				       *)
(*******************************************************************************)

(**********************************************************************************)
(* Function Definitions								  *)
(* 										  *)
(* We can tell Lambda Calculus how to compute things by writing down functions.	  *)
(* We call functions in Lambda Calculus "lambda terms", and look something like	  *)
(* this										  *)
(* 										  *)
(*   lambda x . x								  *)
(* 										  *)
(* Which is the identity function that you've seen a couple of times now. Let's	  *)
(* dissect what it is exactly that we wrote down. Clearly, there are 4 parts to	  *)
(* this expression.								  *)
(* 										  *)
(* 1. The keyword "lambda". 							  *)
(*    We already know this means "I am writing a function now"			  *)
(* 										  *)
(* 2. An parameter named "x". 							  *)
(*    This is the name of the parameter to the function we're defining. In Lambda *)
(*    Calculus, functions have only one parameter and only one return value. We	  *)
(*    give the parameter a name so we can refer to it later.			  *)
(* 										  *)
(* 3. A dot ".".								  *)
(*    This just separates the parameter from the body of the function. It doesn't *)
(*    have any fancy meaning, it just separates the arguments from the body.	  *)
(* 										  *)
(* 4. Another "x".								  *)
(*    Everything after the dot "." constitutes the body of a function, and since  *)
(*    the body of this function is just its argument, this function does nothing  *)
(*    more than return the argument it received. 				  *)
(* 										  *)
(* So clearly `lambda x . x` is the identity function.				  *)
(* Note that we usually put parenthesis around function expressions, it helps	  *)
(* clarify what lives inside and outside the function when our expressions	  *)
(* get larger. So we would typically write the identity function `lambda x . x`	  *)
(* as										  *)
(* 										  *)
(*   (lambda x . x)								  *)
(* 										  *)
(* Now we're learning the Lambda Calculus because every compiler for a functional *)
(* programming language (and many compilers for non-functional languages!) 	  *)
(* translate their ultra-sophisticated-hyper-complex "source" language, the one	  *)
(* that programmers program in, to a much simpler form that is based directly on, *)
(* you guessed it, the Lambda Calculus. You can probably already tell that it's   *)
(* pretty small and simple, and that's exactly what makes it a nice language for  *)
(* compilers to deal with. That's why we're going to use it too.		  *)
(**********************************************************************************)

(**************************************************************************)
(* Function Calls							  *)
(* 									  *)
(* Since we can define functions, it only makes sense that we can call 	  *)
(* them! In Lambda Calculus, we call functions by just putting the 	  *)
(* argument to the right of the function. Like this			  *)
(* 									  *)
(*   (lambda x . x) a							  *)
(* 									  *)
(* Which evaluates to							  *)
(* 									  *)
(*   a									  *)
(* 									  *)
(* Let's examine how that works. It turns out evaluating expressions in	  *)
(* the Lambda Calculus happens in a couple of steps.			  *)
(* 									  *)
(* 1. Look at what kind of expression you have				  *)
(*    1.1) Something like `x` is a variable, variables evaluate to	  *)
(*         themselves. For example, the variable `x` just evaluates to	  *)
(*         the variable `x`. You're done evaluating! Stop here!		  *)
(*    1.2) Something like `(lambda y . y)` is a function. Functions that  *)
(*         occur by themselves also just evaluate to themselves. So 	  *)
(*         the function `(lambda y . y)` evaluates to `(lambda y . y)`.	  *)
(*         You're done evaluating! Stop here!				  *)
(*    1.3) Something like `(lambda y . y) a` is a function application.	  *)
(*         Go to step 2!						  *)
(*    1.4) Something weird like `x x` is an application of a variable to  *)
(*         a variable. This doesn't make a whole lot of sense yet, but	  *)
(*         if later down the road `x` gets replaced with a function, then *)
(*         `x x` turns into calling a function with itself as its	  *)
(*         argument. This has cool uses we'll see later.		  *)
(*         ...By the way: You're done evaluating! Stop here!		  *)
(*  									  *)
(* 2. Evaluate the argument of the application. 			  *)
(*    so if you see an expression like					  *)
(* 									  *)
(*      (lambda x . x) ((lambda y . y) a)				  *)
(* 									  *)
(*    you need to evaluate the argument of `(lambda x . x)` first. This   *)
(*    means evaluating `((lambda y . y) a)`, which is just `a`. This 	  *)
(*    gives you								  *)
(* 									  *)
(*      (lambda x . x) a						  *)
(* 									  *)
(* 3. Rip out the body of the function, and in that function body, 	  *)
(*    replace every occurrence of the parameter with the argument to	  *)
(*    the function. So, if we get an expression like			  *)
(* 									  *)
(*      (lambda x . x) a						  *)
(* 									  *)
(*    Then the parameter is `x`, the body is `x`, and the argument 	  *)
(*    is `a`. Replacing every occurrence of `x` in the body `x` with	  *)
(*    `a` yields the result						  *)
(* 									  *)
(*      a								  *)
(* 									  *)
(* 4. Evaluate this result. In many cases, the result of replacing     	  *)
(*    every occurrence of the parameter with the argument in the body	  *)
(*    of a function may not return a fully evaluated result.		  *)
(*    You're done evaluating! Stop Here!				  *)
(**************************************************************************)

(***********************************************************************)
(* Examples to Help Clarify					       *)
(* 								       *)
(* Here are some examples of Lambda Calculus expressions and what they *)
(* evaluate to. 						       *)
(* 								       *)
(* 1. (lambda x . x x) a					       *)
(* => a a							       *)
(* Think: "replace every occurrence of `x` in `x x`, with `a`"	       *)
(* 								       *)
(* 2. a (lambda x . x)       					       *)
(* => a (lambda x . x)						       *)
(* Think: "replace every occurrence of 				       *)
(*         nothing in `a`, with `(lambda x . x)`"		       *)
(* 								       *)
(* 3. (lambda a . a) (lambda b . b) 				       *)
(* => (lambda b . b)						       *)
(* Think: "replace every occurrence of `a` in `a`, 		       *)
(*         with `(lambda b . b)`"				       *)
(*      							       *)
(* 4. (lambda x . x x) ((lambda y . y) a)			       *)
(* => (lambda x . x x) a					       *)
(* => a a							       *)
(* Think: "replace every occurrence of `y` in `y` with `a`"	       *)
(* Then:  "replace every occurrence of `a` in `x x` with `a`"	       *)
(*      							       *)
(* 6. (lambda x . (lambda y . x)) a b				       *)
(* => (lambda y . a) b						       *)
(* => a								       *)
(* 								       *)
(* 5. (lambda x . (lambda y . y)) a b				       *)
(* => (lambda y . y) b						       *)
(* => b								       *)
(***********************************************************************)


(* Any expression in the Lambda Calculus can be one of 3 things:
 * 1. A Function
 *    Functions consist of a parameter name and a function body.
 *    The body of a function is another expression in the 
 *    Lambda Calculus
 * 2. A Function Call, which we'll call an "Application" 
 *    Function Calls consist of a function to be called,
 *    and the argument it is being given. Both of these
 *    are Lambda Calculus expressions
 * 3. A Variable
 *    Variables just consist of a name, we can use a string
 *    to represent the name of a variable.
 *)
datatype LambdaCalculus = Function of string * LambdaCalculus
			| Application of LambdaCalculus * LambdaCalculus
			| Variable of string

(* Here's how we can construct what we call a "Syntax Tree" for a
 * test expression. We'll use this to test our code from here on out.
 *)
val test_expression : LambdaCalculus = 
    (Application 
	 (Application 
	      (Function ("x", Function ("y", Variable "y")), Variable "a"), Variable "b"))

(* It's really useful to define a `to_string` function for most datatypes.
 * This gives us a nicely presented view of any expression we create.
 * This function takes a LambdaCalculus syntax tree as input, and returns
 * a nice string representation of it.
 *)
fun to_string ( expression : LambdaCalculus ) : string =
  case expression of
      Variable name => name
    | Function (parameter, body) => "(lambda " ^ parameter ^ ". " ^ toString body ^ ")"
    | Application (function, argument) => toString function ^ " " ^ toString argument


(* And now we can test our `to_string` function *)
val printout_before_evaluating : string = to_string test_expression

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

    (* Variables evaluate to themselves *)
      Variable name => 
      Variable name

    (* Functions also evaluate to themselves, 
     * but we can evaluate the body of the function.
     *)
    | Function (argument, body) => 
      Function (argument, evaluate body)

    (* Function Application is where the meat of 
     * evaluation takes place. 
     *)
    | Application (function, argument) => 
      (* The `let ... in ... end` expression lets us
       * define local values. The values defined between
       * `let` and `in` can be used in the expression
       * between `in` and `end`. They can't be used outside 
       * of that expression. This is why they are called
       * "local" to that expression. Values that everyone
       * can use are called "global".
       *)
      let
	  val evaluated_function = evaluate function
	  val evaluated_argument = evaluate argument
      in
	  case evaluated_function of

	    (* The Application of a Variable to anything just 
	     * evaluates to the Application of a Variable to anything
	     *)
	      Variable v => 
	      Application (Variable v, evaluated_argument)

	    (* The Application of an Application to anything just
	     * evaluates to the Application of an Application
	     * to anything 
	     *)
	    | Application a => 
	      Application (Application a, evaluated_argument)

	    (* The Application of a Function to anything, is the body
	     * of the function, with every occurrence of the parameter
	     * replaced by the argument. We then evaluate that result
	     * in case it can be reduced further.
	     *)
	    | Function (parameter, body) => 
	      evaluate (replace (body, Variable parameter, evaluated_argument))
      end


(* And what it looks like after evaluation *)
val printout_after_evaluating  = to_string (evaluate test_expression)
