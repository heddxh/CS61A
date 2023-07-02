from lab05 import *

# Debug add_tree
numbers = tree(1,
                [tree(2,
                      [tree(3),
                       tree(4)]),
                 tree(5,
                      [tree(6,
                            [tree(7)]),
                       tree(8)])])

print_tree(add_trees(numbers, numbers))