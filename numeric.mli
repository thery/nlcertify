
module type T =
sig
  include Numerical_plugin.T
end


val of_string : string -> (module T)

(*module Ocaml_float : Numerical_plugin.T*)

