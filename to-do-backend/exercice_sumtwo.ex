#################################################
###########JavaScript Solution###################
#################################################

# var twoSum = function(nums, target) {
#   let nums_finded = []
#   let solution = []
#
#   nums.forEach((num, index, nums_again) => {
#     diff = target - num
#
#     if (nums_finded.indexOf(diff) > -1) {
#       solution = [nums_again.indexOf(diff), index]
#     } else {
#       nums_finded.push(num)
#     }
#   })
#
#   return solution
# }

# defmodule SolutionWrong do
#   @spec two_sum(nums :: [integer], target :: integer) :: [integer]
#   def two_sum(nums, target) do
#     nums_with_keys = Enum.with_index(nums)
#
#     nums_with_keys
#     |> Enum.map(fn {nums_k, nums_v} ->
#                   Enum.map(nums_with_keys,
#                     fn {tg_k, tg_v} ->
#                       nums_v === 0 &&
#                       tg_v === 0 &&
#                       {true, true} ||
#                       {tg_k + nums_k, nums_v}
#                     end
#                   )
#                 end)
#     |> Enum.map(fn list_with_keys ->
#                   Enum.find(list_with_keys,
#                     fn {list_k, list_v} ->
#                       list_k === target && list_v
#                     end
#                   )
#                 end)
#     |> Enum.filter(& !is_nil(&1))
#     |> Enum.map(fn {_, result_v} -> result_v end)
#   end
# end

defmodule Solution do
  def twoSum(nums, target) do
    nums
    |> Enum.with_index()
    |> Enum.reduce_while(%{}, fn {num, index}, acc ->
      diff = target - num

      IO.inspect "#{target} - #{num}"
      IO.inspect diff
      IO.inspect acc

      if Map.has_key?(acc, diff) do
        IO.inspect index
        IO.inspect acc, label: "No if"
        {:halt, [Map.get(acc, diff), index]}
      else
        {:cont, Map.put(acc, num, index)}
      end
    end)
  end
end

#IO.inspect Solution.twoSum([2,7,11,15], 9), label: "Input: nums = [2,7,11,15], target = 9 Output"
#IO.inspect Solution.twoSum([3,2,4], 6), label: "Input: nums = [3,2,4], target = 6 Output"
# IO.inspect Solution.twoSum([3,3], 6), label: "Input: nums = [3,3], target = 6 Output"
IO.inspect Solution.twoSum([-1,-2,-3,-4,-5], -8), label: "Input: nums = [-1,-2,-3,-4,-5], target = -8 Output"
