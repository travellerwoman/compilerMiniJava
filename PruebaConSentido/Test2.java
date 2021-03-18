public class LinkedList {
    Node head;

    public LinkedList insert (int data){
        // Create node
        Node newNode = new Node(data);
        newNode.next = null;

        // If the list is empty we need a new head
        if (this.head == null){
            this.head = newNode;
        }
        // If the list is not empty we put the new node at the end
        else{
            Node last = head;
            while ( last.next != null ){
                last = last.next;
            }
            last.next = newNode;
        }

        LinkedList list = this;
        return list;

    }

    public void printList (){
        Node thisNode = this.head;

        System.out.println("[DS] Linked list: ");

        while ( thisNode.next != null ) {
            // Print current node
            System.out.println( thisNode.data + " ");
            // Next node
            thisNode = thisNode.next;
        }

        System.out.println();
    }
}
