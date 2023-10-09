defmodule Test do
  defmacro test label, expr do
    quote do
      case unquote(expr) do
        [do: :ok] ->
          IO.puts("🟢 " <> unquote(label))

        [do: {:error, code, expected, actual}] ->
          IO.puts("🔴 " <> unquote(label))
          IO.puts("      Code: #{code}")
          IO.puts("  Expected: #{expected}")
          IO.puts("    Actual: #{actual}")
      end
    end
  end

  defmacro assert_equal(expr, expected) do
    expr_string = Macro.to_string(expr)

    quote do
      actual = unquote(expr)

      if actual == unquote(expected) do
        :ok
      else
        {:error, unquote(expr_string), inspect(unquote(expected)), inspect(actual)}
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

  test "A stack after pushing is not empty" do
    stack = Stack.new()
    Stack.push(stack, :foo)
    assert_equal(Stack.empty?(stack), false)
  end
end
