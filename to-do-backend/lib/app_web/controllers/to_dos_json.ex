defmodule AppWeb.ToDosJSON do
  alias App.ToDos.ToDo

  def create(%{to_do: to_do}) do
    %{
      message: "ToDo created as success!",
      data: data(to_do)
    }
  end

  def list(%{to_do_list: to_do_list}), do: %{data: to_do_list}
  def update(%{to_do_list: to_do_list}), do: %{message: "ToDo(s) changed as success!", data: to_do_list}
  def delete(%{to_do: to_do}), do: %{message: "ToDo deleted as success!", data: data(to_do)}

  defp data(%ToDo{} = to_do) do
    %{
      id: to_do.id,
      description: to_do.description,
      status: to_do.status
    }
  end
end
