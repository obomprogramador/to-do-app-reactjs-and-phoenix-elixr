defmodule App.ToDos.Update do
  alias App.ToDos.ToDo
  alias App.Repo

  def call(%{"to_do_list" => to_do_list}) do
    to_do_list
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {to_do, index}, acc ->
      case Repo.get(ToDo, to_do["id"]) do
        nil ->
          {:cont, List.insert_at(acc, (length(to_do_list) + 1), %{"id" => to_do["id"], "error" => "tupple_not_found"})}
        to_do_founded ->
          if index == (length(to_do_list) - 1) do
            {:cont, {:ok, List.insert_at(acc, (length(to_do_list) + 1), update(to_do_founded, to_do))}}
          else
            {:cont, List.insert_at(acc, (length(to_do_list) + 1), update(to_do_founded, to_do))}
          end
      end
    end)
  end

  defp update(to_do, params) do
    to_do
    |> ToDo.changeset(params)
    |> Repo.update()
    |> Kernel.elem(1)
  end
end
