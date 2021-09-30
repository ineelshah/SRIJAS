# Some Common Use-Cases for the web app
### Case 1: Incomplete input parameters:

In our code, to make sure that everyhing runs smoothly, we ensure that all of the form fields are completed before the form is submitted. 
Because of this, sometimes you may see an error like this:
![Use-Case-Image](https://github.com/ineelshah/SRIJAS/blob/main/images/case1_1.jpg)

Or like this:

![Use-Case-Image](https://github.com/ineelshah/SRIJAS/blob/main/images/case1_2.jpg)
 
Simply make sure that:
* You have filled something in each of the form fields 
* You have selected a file from your local device for uploading
* You have put in the fields in the proper format. Example: email should be in the 'xyz@abc.efg' format.
  
### Case 2: Selecting the wrong type of document:
Even after following the above steps, if, for some reason, the web server displays an error as follows:
  ![Use-Case-Image](https://github.com/ineelshah/SRIJAS/blob/main/images/case2_1.jpg)
    
    
It is likely because of one of 2 things:
  * The file selected is not of .pdf format
  * The file directory does not have the required permissions
  
To rectify this, please select a .pdf file only and make sure that the sendData.php file has atleast '755' permissions. 

    
### Case 3: Everything runs smoothly:
When everything has been executed properly, you will be redirected to the same index.php page and can see the results as in:
![Use-Case-Image](https://github.com/ineelshah/SRIJAS/blob/main/images/case3_1.jpg)
![Use-Case-Image](https://github.com/ineelshah/SRIJAS/blob/main/images/case3_2.jpg)
![Use-Case-Image](https://github.com/ineelshah/SRIJAS/blob/main/images/case3_3.jpg)
      
As you can see, the appropriated user and resume tables will be correctly mapped and updated in this case.
