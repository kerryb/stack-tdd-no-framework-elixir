defmodule Test do
  defmacro assert_equal(expr, expected) do
    expr_string = Macro.to_string(expr)

    quote do
      result = unquote(expr)

      unless result == unquote(expected) do
        raise("""

              Code: #{unquote(expr_string)}
          Expected: #{inspect(unquote(expected))}
            Actual: #{inspect(result)}
        """)
      end
    end
  end
end

defmodule StackTest do
  import Test

  stack = Stack.new()
  assert_equal(Stack.empty?(stack), true)
end
