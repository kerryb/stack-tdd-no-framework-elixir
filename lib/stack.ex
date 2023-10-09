defmodule Stack do
  defstruct item: nil

  def new do
    %__MODULE__{}
  end

  def empty?(stack) do
    is_nil(stack.item)
  end

  def push(stack, item) do
    %{stack | item: item}
  end

  def pop(stack) do
    stack.item
  end
end
