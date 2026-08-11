#!/usr/bin/env ruby
################################
# Activity 05 / Noah Gallego 
# CSUB - CS 3500
# Date: 03/30/2025
###############################

# Import Packages
require 'csv'

# Enable Tail-Call Optimization
RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

# Cache First Two Values
@cache = {}; @cache[1] = 1; @cache[2] = 1;

# Part 1: Binet's Formula Accuracy
def binet(n)
    sqrt5 = Math.sqrt(5); 
    fibonacci_binnet = (( ((1 + sqrt5)**n) - ((1  - sqrt5)**n) ) / ((2**n) * sqrt5)).round;
end

# Cached Fibonacci
def real_fib(n)
    @cache[n] ||= real_fib(n-1) + real_fib(n-2)
end

# Difference In Error
def accuracy()
    n = 1
    while (real_fib(n) - binet(n)).abs == 0
        n += 1
    end

    return n - 1 # Last Good Match
end

print "Part 1:\n*******\n"
puts "Ruby's implementation of Binet's formula is accurate until n = #{accuracy()}."
print "** I Rounded Binet's Implementation For A Higher 'n'.\n\n"


# Part 2: Searching / Sorting Algorithms

# Regular Recursive Sorting Algorithms
# QuickSort - Regular
def quicksort(array, from=0, to=nil)
    if to == nil
        to = array.count - 1
    end

    if from >= to
        return
    end

    pivot = array[from]

    min = from
    max = to

    free = min

    while min < max
        if free == min 
            if array[max] <= pivot
                array[free] = array[max]
                min += 1
                free = max
            else
                max -= 1
            end
        elsif free == max 
            if array[min] >= pivot 
                array[free] = array[min]
                max -= 1
                free = min
            else
                min += 1
            end
        end
    end

    array[free] = pivot

    quicksort array, from, free - 1
    quicksort array, free + 1, to
end

# Merge Sort - Regular
# Recursive part that halves the arrays
def mergesort(array)
    return array if array.length == 1
    middle = array.length / 2
    merge mergesort(array[0...middle]), mergesort(array[middle..-1])
end
  
# Merge function that combines the arrys  
def merge(left, right)
    result = []
    until left.length == 0 || right.length == 0 do
      result << (left.first <= right.first ? left.shift : right.shift)
    end
    result + left + right
end

# Binary Search - Regular
def binary_search_iter(arr, el)
    max = arr.length - 1
    min = 0
  
    while min <= max 
        mid = (min + max) / 2
        if arr[mid] == el
            return mid
        elsif arr[mid] > el 
            max = mid - 1
        else 
            min = mid + 1
        end

        return nil 
    end
end

# Tail-Recursive Searching / Sorting Algorithms
# QuickSort - Tail Recursive
def quicksort_tail(array, from = 0, to = nil)
    to ||= array.length - 1
    return if from >= to
  
    pivot = array[from]
    min = from
    max = to
    free = min
  
    while min < max
      if free == min
        if array[max] <= pivot
          array[free] = array[max]
          min += 1
          free = max
        else
          max -= 1
        end
      elsif free == max
        if array[min] >= pivot
          array[free] = array[min]
          max -= 1
          free = min
        else
          min += 1
        end
      end
    end
  
    array[free] = pivot
  
    # Tail-recursive structure (Techincally The Same)
    quicksort_tail(array, from, free - 1)
    quicksort_tail(array, free + 1, to)
end

# Tail-Recursive Merge-Sort
def mergesort_tail(array)
    return array if array.length <= 1
  
    # Tail-call recursion split
    def merge_tail(left, right, result = [])
      return result + left + right if left.empty? || right.empty?
  
      if left.first <= right.first
        merge_tail(left[1..-1], right, result + [left.first])
      else
        merge_tail(left, right[1..-1], result + [right.first])
      end
    end
  
    mid = array.length / 2
    left = mergesort_tail(array[0...mid])
    right = mergesort_tail(array[mid..-1])
    merge_tail(left, right)
end

# Tail-Recursive Binary Search
def binary_search_tail(arr, el, min = 0, max = nil)
    max ||= arr.length - 1
    return nil if min > max
  
    mid = (min + max) / 2
  
    return mid if arr[mid] == el
    if arr[mid] > el
      binary_search_tail(arr, el, min, mid - 1)
    else
      binary_search_tail(arr, el, mid + 1, max)
    end
end

# Timing Function (To Avoid Repetition)
def timing()
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    result = yield
    finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    return result, (finish - start)
end

print "\nPart 2:\n********\n"
print "Enter element to search: "
element = gets.chomp.to_i
puts

list1 = File.read("list1.txt").split.map(&:to_i)
list2 = File.read("list2.txt").split.map(&:to_i)

print "\nAverage times to sort and search are:\n"
print "List       Algorithm                        Time to sort list             Algorithm                           Time to search input\n"
print "********   **********                       *****************             *********                           ********************\n"

# ------ LIST 1 ------
# Recursive Quick Sort
list = list1.dup
_, sort_time = timing() { quicksort(list) }
_, search_time = timing() { binary_search_tail(list, element) }
puts "list 1     Quick Sort - Recursive           #{sort_time.round(6)} seconds          Binary Search - Recursive                     #{search_time.round(6)} seconds"

# Tail Recursive Quick Sort
list = list1.dup
_, sort_time = timing() { quicksort_tail(list) }
_, search_time = timing() { binary_search_tail(list, element) }
puts "list 1     Quick Sort - Tail Recursive      #{sort_time.round(6)} seconds          Binary Search - Tail Recursive               #{search_time.round(6)} seconds"

# Recursive Merge Sort
list = list1.dup
sorted, sort_time = timing() { mergesort(list) }
_, search_time = timing() { binary_search_tail(sorted, element) }
puts "list 1     Merge Sort - Recursive           #{sort_time.round(6)} seconds          Binary Search - Recursive                    #{search_time.round(6)} seconds"

# Tail Recursive Merge Sort
list = list1.dup
sorted, sort_time = timing() { mergesort_tail(list) }
_, search_time = timing() { binary_search_tail(sorted, element) }
puts "list 1     Merge Sort - Tail Recursive      #{sort_time.round(6)} seconds          Binary Search - Tail Recursive               #{search_time.round(6)} seconds"

# ------ LIST 2 ------
# Same logic as above
list = list2.dup
_, sort_time = timing() { quicksort(list) }
_, search_time = timing() { binary_search_tail(list, element) }
puts "list 2     Quick Sort - Recursive           #{sort_time.round(6)} seconds          Binary Search - Recursive                    #{search_time.round(6)} seconds"

list = list2.dup
_, sort_time = timing() { quicksort_tail(list) }
_, search_time = timing() { binary_search_tail(list, element) }
puts "list 2     Quick Sort - Tail Recursive      #{sort_time.round(6)} seconds          Binary Search - Tail Recursive               #{search_time.round(6)} seconds"

list = list2.dup
sorted, sort_time = timing() { mergesort(list) }
_, search_time = timing() { binary_search_tail(sorted, element) }
puts "list 2     Merge Sort - Recursive           #{sort_time.round(6)} seconds          Binary Search - Recursive                    #{search_time.round(6)} seconds"

list = list2.dup
sorted, sort_time = timing() { mergesort_tail(list) }
_, search_time = timing() { binary_search_tail(sorted, element) }
puts "list 2     Merge Sort - Tail Recursive      #{sort_time.round(6)} seconds          Binary Search - Tail Recursive               #{search_time.round(6)} seconds"

# Part 3 - Is Palindrome
# Non-recursive
def nrpalindrome(str)
  str == str.reverse
end

# Recursive
def rpalindrome(str)
  return true if str.length <= 1
  return false if str[0] != str[-1]
  rpalindrome(str[1..-2])
end

# tpalindrome / tail-revursive implementation
def trpalindrome(str)
  def helper(str, left, right)
    return true if left >= right
    return false if str[left] != str[right]
    helper(str, left + 1, right - 1)
  end
  helper(str, 0, str.length - 1)
end

lines = File.readlines("palindromes_to_check.txt", encoding: "UTF-8").map(&:strip)

def clean_string(str)
    str.gsub(/[^a-zA-Z0-9]/, "").downcase
end

print "\nPart 3:\n"
print "***********\n"
print "List                Number of palindromes       Time to process palindromes_to_check.txt\n"
print "**************      ************************    *****************************************\n"

# NRPalindrome
nr_count, nr_time = timing() {
  lines.count { |line| nrpalindrome(clean_string(line)) }
}
puts "nrpalindrome        #{nr_count.to_s.ljust(28)} #{nr_time.round(6)} seconds."

# RPalindrome
r_count, r_time = timing() {
  lines.count { |line| rpalindrome(clean_string(line)) }
}
puts "rpalindrome         #{r_count.to_s.ljust(28)} #{r_time.round(6)} seconds."

# TRPalindrome
tr_count, tr_time = timing() {
  lines.count { |line| trpalindrome(clean_string(line)) }
}
puts "trpalindrome        #{tr_count.to_s.ljust(28)} #{tr_time.round(6)} seconds."

# Identify Fastest
times = {
  "nrpalindrome" => nr_time,
  "rpalindrome" => r_time,
  "trpalindrome" => tr_time
}

fastest_time = nil
fastest_method = nil

times.each do |method, time|
  if fastest_time == nil || time < fastest_time
    fastest_time = time
    fastest_method = method
  end
end
puts "\nThe fastest algorithm to identify palindromes is: #{fastest_method}"

# For Recursion.pdf
# Find longest palindrome (by cleaned string length)
longest = lines
  .select { |line| nrpalindrome(clean_string(line)) }
  .max_by { |line| clean_string(line).length }

puts "\nLongest palindrome in palindromes_to_check.txt: #{longest}"

# Count palindromes by word count
counts_by_word = Hash.new(0)
lines.each do |line|
  word_count = line.split.size
  cleaned = clean_string(line)
  if [3, 4, 5].include?(word_count) && nrpalindrome(cleaned)
    counts_by_word[word_count] += 1
  end
end

puts "Number of 3-word palindromes: #{counts_by_word[3]}"
puts "Number of 4-word palindromes: #{counts_by_word[4]}"
puts "Number of 5-word palindromes: #{counts_by_word[5]}"