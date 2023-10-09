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
    stack = Stack.push(stack, :foo)
    assert_equal(Stack.empty?(stack), false)
  end

  test "A pushed item can be popped" do
    stack = Stack.new()
    stack = Stack.push(stack, :foo)
    {_stack, item} = Stack.pop(stack)
    assert_equal(item, :foo)
  end

  test "Items are popped in LIFO order" do
    stack = Stack.new()
    stack = stack |> Stack.push(:foo) |> Stack.push(:bar)
    {stack, item} = Stack.pop(stack)
    assert_equal(item, :bar)
    {stack, item} = Stack.pop(stack)
    assert_equal(item, :foo)
  end

  test "A stack is empty after popping all items" do
    stack = Stack.new()
    stack = Stack.push(stack, :foo)
    {stack, _item} = Stack.pop(stack)
    assert_equal(Stack.empty?(stack), true)
  end

  test "Popping an empty stack returns an error" do
    stack = Stack.new()
    assert_equal(Stack.pop(stack), {:error, :empty})
  end
end
