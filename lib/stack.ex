defmodule Stack do
  defstruct items: []

  def new do
    %__MODULE__{}
  end

  def empty?(stack) do
    Enum.empty?(stack.items)
  end

  def push(stack, item) do
    Map.update!(stack, :items, &[item | &1])
  end

  def pop(stack) do
    [item | items] = stack.items
    {%{stack | items: items}, item}
  end
end
