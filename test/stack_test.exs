defmodule Test do
  defmacro test label, expr do
    quote do
      try do
        unquote(expr)
        IO.puts("🟢 " <> unquote(label))
      rescue
        e ->
          IO.puts("🔴 " <> unquote(label))
          IO.puts(e.message)
      end
    end
  end

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

  test "A new stack is empty" do
    stack = Stack.new()
    assert_equal(Stack.empty?(stack), true)
  end
end
