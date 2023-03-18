class Node
    attr_accessor :data, :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end
end

class Tree
    attr_accessor :root

    def initialize(arr)
        @root = build_tree(sorted_arr(arr))
    end

    def sorted_arr(arr)
        arr.sort.uniq        
    end

    def build_tree(arr,starter=0,ender = arr.length - 1)

        return nil if starter > ender
        
        mid = (starter + ender)/2

        node = Node.new(arr[mid])

        node.left = build_tree(arr,starter,mid-1)

        node.right = build_tree(arr,mid+1,ender)

        return node        
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def search(data, node = @root)
        if node.nil? 
            puts "not found #{data}"
            return nil

        elsif node.data < data
           search(data,node.right)

        elsif node.data > data
           search(data, node.left)

        else
            node
        end
        
    end

    def insert(value, node = @root)
        if node.nil?
            @root = Node.new(value)            
            puts "added new node"
        else
            if node.data == value
                puts "Element already exists"
                return
            elsif node.data < value
                if node.right.nil?
                    node.right = Node.new(value)
                else
                    node = node.right
                    return insert(value,node)
                end
                    
            elsif  node.data > value
                if node.left.nil?
                    node.left = Node.new(value)
                else
                    node = node.left
                    return insert(value,node)
                end
            end
        end
    end

    def delete(value,node = @root)
        if node.nil?
            node            

        elsif node.value > value
            node.left = delete(value,node.left)

        elsif node.value < value
            node.right = delete(value,node.right)

        else
            # node to del has 1 child
            return node.right if node.left.nil?

            return node.left if node.right.nil?
            
            # node to del has 2 children
            replacement_n = min_val(node)

            node.data = replacement_n.data

            node.right = node.next
                        
        end
    end

    def min_val(node)
        node = node.left until node.left.nil?
        node
    end

    def level_order(node = @root)
        if node.nil?
            return
        end

        que = []
        que.push(node)

        until que.empty?
            current_node = que[0]
            print current_node.data 
            print " "

            que.push(current_node.left) unless current_node.left.nil?

            que.push(current_node.right) unless current_node.right.nil?

            que.shift
        end
    end

    def preorder(node = @root)
        if node.nil?
            return
        end

        print node.data
        print " "

        preorder(node.left)
        preorder(node.right)
        
    end

    def inorder(node = @root)
        if node.nil?
            return
        end

        inorder(node.left)
        print node.data
        print " "
        inorder(node.right)        
    end

    def postorder(node = @root)
        if node.nil?
            return
        end

        postorder(node.left)
        postorder(node.right)
        print(node.data)
        print " "
    end

    def height(node = @root)

        return 0 if node.nil?

        if node.left.nil? && node.right.nil?
            return 0
            
        elsif node.left.nil?
            return 1 + height(node.right)
            
        elsif node.right.nil?
            return 1 + height(node.left)
            
        else
            return 1 + [height(node.left), height(node.right)].max
        end

    end

    def balanced?
        node = @root

        dif = height(node.left) - height(node.right)
        puts dif >= -1 && dif <= 1

    end

    def rebalance(node = @root)
        initialize(inorder(node))
    end

end

one = Tree.new([1, 7, 4, 23, 8, 9,56,34])

# puts one.pretty_print

# puts one.search(0)

# one.insert(10)

puts one.pretty_print

# one.level_order

# one.preorder
# puts ""
# one.inorder
# puts ""
# one.postorder

# puts one.height

one.balanced?