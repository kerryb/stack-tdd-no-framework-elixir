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

  def pop(%{items: []}), do: {:error, :empty}

  def pop(stack) do
    [item | items] = stack.items
    {:ok, %{stack | items: items}, item}
  end
end
