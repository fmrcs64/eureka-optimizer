
class Solution:
    def twoSum(nums: list[int], target: int):
        i_found_a_pair = False
        while not i_found_a_pair:
         for idx1, i in enumerate(nums):
            for idx2, n in enumerate(nums):
                if i + n == target and idx1 != idx2:
                    i_found_a_pair = True
                    print(f"{i}, {n}")
                    return [idx1, idx2]
                   # print(f"[{idx1}, {idx2}]")
                
def main():
    Solution.twoSum([1,2,5,7,120,43,5],10)

main()