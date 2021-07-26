/*
There are lists where insertion should ensure the ordering of data elements. 
Since  the elements  are  in  ascending  order  the  search  can  terminate  once equal or greater element is found. 
Implement a singly linked list of ordered integers(ascending/descending) with insert, search and display operations.

Ordering in the following code-> Ascending.
*/

#include<iostream>
using namespace std;

class node{
	public:
		int num;
		node*next;
};

class singlyLinkedList{
	private:	
	node*head;
	
	public:
	void insert(int val){ 
		
		if(head == NULL){ //If head==NULL, then the first value inserted must be head.
		head = new node();
		head->num = val;
		head->next = NULL;//the pointer of new head points to NULL since it is the only element in the list
		return;
	}
		node * new_node = new node; //define new node that will be inserted after insertion of first element
		new_node->num = val;
		new_node->next = NULL;
		
		node* curr = head; //define a pointer to get current node
		
		if(val < head->num){ //new node will beacome the head and it will point to the address of current head
			new_node->next = head;
			head = new_node;
			return;
		}
		while(curr->next != NULL && val >= curr->next->num){ 
			curr = curr->next; //move on
		}
		
		new_node->next = curr->next; //inserting number in the middle
		curr->next = new_node;
		
		};	
	void search(int a){
		node*curr = head;
		int index = 1;
		
		if(head==NULL){
			cout <<"Singly link list is empty." << endl;
			return;
		}
		while(curr->next != NULL){
			if(curr->num == a){
			cout << a << " is at position " << index << endl;
			return;
		}
			index++;
			curr = curr->next;
		}
		cout << "There is no such number." << endl;
		
	}
		
	void display(){
		if(head==NULL){
			cout <<"Singly linked list is empty." << endl;
			return;
	}
		else{
			cout<< "Singly linked list values are "<< endl;
			node * curr = head;
			while(curr != NULL) //traverse the list till the end
			{
			cout << curr->num << endl;
			curr = curr->next;
		}
		}
		
	}
	
};


int main()
{
	int option,number,search;
	singlyLinkedList *list = new singlyLinkedList();
	
	do{
	cout << "-----------------------------------" << endl;
	cout << "Operations on a Singly Linked List" << endl;
	cout << "-----------------------------------" << endl;
	cout << "1. Insert values" << endl;
	cout << "2. Search values" << endl;
	cout << "3. Display linked list" << endl;
	cout << "4. EXIT" << endl;
	cout << endl;
	cout << "Choose your option." << endl;
	cin >> option;
	
	switch(option){

	case 1: 
		cout<<"Enter the numbers you want to enter." << endl;
		cin >> number;
		list->insert(number);
		break;
		
	case 2:
		cout << "Enter the number you want to search" << endl;
		cin>> search;
		list ->search(search);
		break;
	
	
	case 3:
		list-> display();
		break;
	
	case 4: 
		break;	
		
	default:
		cout << "Invalid input!" << endl;
		break;
		
	}
	}
	while(option != 4);
	return 0;
	}	
	



