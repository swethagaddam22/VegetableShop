import mysql.connector as db
con=db.connect(username="root",password="Swetha@123",host="localhost", database="miniproject")
cur=con.cursor()
class vegshop:
    def menu(self):
        cur.callproc('menu_list',[])
        for i in cur.stored_results():
            x=i.fetchall()
        print(    'item','     ','quantity','     ','costprice')
        for i in x:
            print(i[0],' '*5,i[1],'        ',i[2],'        ',i[4] ,'    ',)
      
    def item_exist(self,item):
        cur.callproc('Check_item',(item,))
        for i in cur.stored_results():
            x=i.fetchall()
        if x[0][0]=='True':
            return True
        else:
            return False
       
    def qntity_check(self,Qnt,item):
        cur=con.cursor()
        cur.callproc('checkveg_qty',(Qnt,item))
        for i in cur.stored_results():
            x=i.fetchall()
        if x[0][0]=='true':
            return True
        else:
            print(" out of stock")
       
    def add_basket(self,item,Qnt):
        cur=con.cursor()
        cur.callproc('add_basket',(item,Qnt))
    

    def update_qnt(self,item,Qnt):
        cur=con.cursor()
        cur.callproc('update_qnt',(item,Qnt))
      
    def bill(self):
        cur=con.cursor()
        cur.callproc('b_update',)
        print('vegname',' '*5,'vegquantity',' '*5,'price')
        for a in cur.stored_results():
            z=a.fetchall()
        for i in range(0,len(z)):
            print(z[i][0],' '*10,z[i][1],' '*12,z[i][2])
        cur.callproc('totalbill',)
        for b in cur.stored_results():
            z=b.fetchall()
        print('-'*50)
        print(' '*20,'Total Bill:',z[0][0])
        print('Thankyou visit again')
        

    def truncate(self):
        cur=con.cursor()
        cur.callproc('trun',)
   
    
       
    def veg_add(self,n,v,q,s,c):
        cur=con.cursor()
        cur.callproc("v_add", (n, v, q, s, c))
       
    def veg_update(self,n,v,q,s,c):
        cur=con.cursor()
        cur.callproc("v_update",(n,v,q,s,c))
      
    def veg_remove(self,n):
        arg=(n,)
        cur=con.cursor()
        cur.callproc("v_remove",arg)

        
    
        
        
        
        
         
         
obj=vegshop()


print('*'*20,'welcome To Online Vegetable Store','*'*20)
while True:
    print('1.admin','2.customer','3.exit')
    ch=int(input('enter a number:'))
    if ch==1:

        print('1.insert new vegetable','2.update vegetables','3.remove vegetables')
        c=int(input("enter a number: "))
        if c==1:
            obj.menu()
            l=["veg_no","Veg_name","Veg_qnty","sell_price","cost_price"]
            l1=[]
            for i in range(len(l)):
                item = input(f"Enter{l[i]}: ")
                l1.append(item)
            obj.veg_add(*l1)
            l1=[]

            
        elif c==2:
            obj.menu()
            k=["veg_no","Veg_name","Veg_qnty","sell_price","cost_price"]
            kk=[]
            for i in range(len(k)):
                item=input(f"Enter{k[i]}: ")
                kk.append(item)
            obj.veg_update(*kk)
            kk=[]
        elif c==3:
            obj.menu()
            l=input('enter the veg:')
            obj.veg_remove(l)
            
        
    elif ch==2:
         print('welcome to our vegetables store')
         
         obj.menu()
         cus_name=input("enter customer name: ")
         while True:
             item=input('enter what do you want:')
             x=obj.item_exist(item)
             if x==True:
                 Qnt=int(input("enter quantity :"))
                 y=obj.qntity_check(Qnt,item)
                 
                 if y==True:
                     obj.add_basket(item,Qnt)
                     obj.update_qnt(item,Qnt)
                     ch=input('if want to buy again:yes/no: ')
                     if ch=='no':
                         print('*'*20,'Bill','*'*20)
                         obj.bill()
                         cur.callproc('miniproject.income',(cus_name,))
                         obj.truncate()
                         
                         break
                        
                     elif ch=='yes':
                         pass
                     else:
                         print('Invalid Input')
                 
                        
             else:
                 print("Item does not exist.")  
         
    elif ch==3:
        print('*'*10,'Total Revenue','*'*10)
        print('cusname',' '*5,'profit',' '*5,'Date')
        cur.callproc("miniproject.revenue_update")
        for a in cur.stored_results():
            z=a.fetchall()
        for b in range(0,len(z)):
            print(z[b][0],' '*5,z[b][1],' '*5,z[b][2])

cur.close()
con.close()    
















 



    
