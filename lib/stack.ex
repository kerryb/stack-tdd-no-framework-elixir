defmodule Stack do
  defstruct empty?: true

  def new do
    %__MODULE__{}
  end

  def empty?(stack) do
    stack.empty?
  end

  def push(stack, _value) do
    %{stack | empty?: false}
  end
end
