signature CORE = 
sig

    datatype t = Variable of Identifier.t

	       | Integer of Integer.t

	       | Function of { argument : Identifier.t,
			       body : t }

	       | Application of { function : t,
				  argument : t }

	       | Primitive of { primitive : Primitive.t,
				argument : t }

    val replace : t * t -> t

    val evaluate : t -> t
			    
end
