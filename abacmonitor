#!/usr/bin/python
# -*- coding: utf-8 -*-
#Kohl Stark
# 1210832503
# CSE 365 Carlos Rubio-Medrano
# Assignment 1
# Necessary Imports
import re
import copy
import sys

# Gather the info and put it in a string, remove quotes
user_input = ' '.join(sys.argv[1:])
#user_input = input("Enter command: ")
temp1 = user_input.strip('\"')
temp2 = temp1.strip('\“')
temp3 = temp2.strip('\”')

user_hold = re.split('; | ', temp1)
#print ('user input: ', user_hold)
# Open and read the information from the specified text file
user_hold[0] == 'load-policy'
f = open(user_hold[1])
data = f.readlines()

# Put the information into a dicitonary 
permissions = {}
for i in data:
    if not i.strip():
        continue
    else:
        key, val = i.split("=")
        permissions[key.strip()] = val.strip()
        
#print ("Attributes: ", permissions['ATTRS'], "\n")
#print ("Permissions: ", permissions['PERMS'], "\n")
#print ("PA's: ", permissions['PA'], "\n")
#print ("Entities: ", permissions['ENTITIES'], "\n")
#print ("AA's: ", permissions['AA'], "\n")
        
# Function to delimit Entities
def Entdelimit(my_str):
    #print ('my_str', my_str)
    for i in my_str:
        hold = ''.join(str(v) for v in my_str)
    
    hold = re.split('; |;', my_str)
    for i in hold:
        if i == '':
            hold.remove(i)
        else:
            hold = [i.replace('<', '') for i in hold]
            hold = [i.replace('>', '') for i in hold]
            #print ("hold2: ", hold)
    return hold

# Function to delimit general information
def delimit(my_str):
    #print ('my_str', my_str)
    for i in my_str:
        hold = ''.join(str(v) for v in my_str)
    #hold = re.split(' : |, ', temp1)
    hold = re.split('; |;', my_str)
    for i in hold:
        if i == '':
            hold.remove(i)
        else:
            hold = [i.replace('<', '') for i in hold]
            hold = [i.replace('>', '') for i in hold]
            hold = [i.replace(';', '') for i in hold]
            #print ("hold2: ", hold)
    return hold

# Funciton to delmit the PA's
def PAdelimit(my_str):
    #print ('my_str', my_str)
    for i in my_str:
        hold = ''.join(str(v) for v in my_str)
    
    hold = my_str.split(" - ")
    for i in hold:
        if i == '':
            hold.remove(i)
        else:
            hold = [i.replace('<', '') for i in hold]
            hold = [i.replace('>', '') for i in hold]
            #print ("hold2: ")
            continue
    return hold
def flatten(lists):
  results = []
  for numbers in lists:
    for i in numbers:
      results.append(i);
    
  return results


# List of Attributes
Attrs = delimit(permissions['ATTRS'])
#print ("Attrs: ", Attrs, "\n")

# Further delmit the Attributes
temp_atts = []
for i in Attrs:
    hold = i.split(", ")
    hold1 = hold[1:]
    temp_atts.append(hold1)
    
# Gets the Attributes without the type, needed for further use
needed_atts = flatten(temp_atts) 

    
second_att = []
perms = []
# Add the attributes into a new list
for j in Attrs:
    hold = j.split(", ")
    second_att.append(hold[1])


# List of Permissions
Perms = delimit(permissions['PERMS'])
#print ("Perms: ", Perms, "\n")

# List of PA's
PA = PAdelimit(permissions['PA'])
#print ("PA's: ", PA, "\n")

# Further delmit the PA List
PA_list = []
for i in PA:
    temp1 = i.replace('"', '') #BIG CHANGE
    hold = re.split(' : |, |; ', temp1)
    PA_list.append(hold)

# List of Entities
Entities = Entdelimit(permissions['ENTITIES'])
#print ("Entities: ", Entities, "\n")

# The main dictionary
main_dict = dict()

for line in Entities:
    # VERY IMPORTANT TO HAVE ':' so it doens't replace all values in list
    main_dict[line] = second_att[:]


# List of AA's
AA = delimit(permissions['AA'])

# Further delimit the AA list
AA_list = []
for i in AA:
    temp1 = i.replace('"', '') # BIG CHANGE
    #print ('this ', temp1)
    hold = re.split(' : |, |: ', temp1)
    AA_list.append(hold)

# Copy the main dictionary for future manipulation
second_dict = copy.deepcopy(main_dict)

# Nested for loop to assign information to Attributes from the AA list
for atts in AA_list:
    for list_atts in atts:
        for key, key_list in main_dict.items():
            if key in list_atts:
                storage = key
                counter = -1
                for i in key_list:
                    counter += 1
                    if i in atts:
                        second_dict[storage][counter] = atts[-1]
                        
# Add Carlos to the fileOwner name
for key, key_list in second_dict.items():
    count = -1
    for items in key_list:
        count += 1
        if items == 'fileOwnerName':
            key_list[count] = '"Carlos"'
                        

# Nested for loops to assign information from PA list to Attributes    
key_count = 0
for key, key_list in second_dict.items():
    hold_list = []
    for lists in PA_list:
        list_count = 0
        if key_list[0] in lists and key_list[0] not in 'role':
            while list_count < len(lists):
                i_count = -1
                for i in key_list:
                    i_count += 1
                    if lists[list_count] in i:
                        key_list[i_count] = lists[list_count+1]
                list_count+=2
            if lists[-1] not in hold_list:
                hold_list.append(lists[-1])
    key_list.append(hold_list)
    key_count += 1

# Check permissions based on info in the dictionary
def check_permission(name, file, env, my_perms):
    # Will hold the desired output
    hold = ''
    for key, key_list in second_dict.items():
        if key in name and my_perms in key_list[-1]:
            hold = 'Permission GRANTED!'
            break
        elif file in key and 'Carlos' in second_dict[file]:
            hold = 'Permission GRANTED!'
            break           
        else:
            hold = 'Permission DENIED!'
    print (hold)

# Adding an entity to the Entities list and to the dictionary          
def add_entity(ent_name):
    second_dict[ent_name] = 'None'
    Entities.append(ent_name)

# Remove and entity from the Entities list and the dictionary
def remove_entity(ent_name):
    if ent_name in second_dict:
        second_dict.pop(ent_name, None)
    Entities.remove(ent_name)

# Add an attribute to the Attribute list
def add_attribute(att_name, att_type):
    together = att_name + ', ' + att_type
    Attrs.append(together)

# Remove an attribute from the attribute list, AA list, PA list and dictionary
def remove_attribute(att_name):
    count = 0
    for i in Attrs:
        if att_name in i:
            break
        count += 1
    Attrs.pop(count)
    
    needed_count = 0
    for i in needed_atts:
        if att_name in i:
            break
        needed_count += 1
    needed_atts.pop(count)
    
    for k in AA_list:
        temp = -1
        for items in k:
            temp += 1
            if att_name in items:
                k.pop(temp)
                
    for key, key_list in second_dict.items():
        flag = None
        for items in PA_list:
            if key_list[needed_count] in items and len(items) < 4:
                flag = True
                key_list.pop(needed_count)
                key_list[-1].pop(0)
        if flag != True:
            key_list.pop(needed_count)
            
    for j in PA_list:
        hold = -1
        for items in j:
            hold += 1
            if att_name in items:
                j.pop(hold)   

# Add permissions to the Perm list
def add_permission(perm_name):
    Perms.append(perm_name)

# Remove a permission from the Perm list, PA list and dictionary
def remove_permission(perm_name):
    Perms.remove(perm_name)
    
    count = 0
    while count != len(PA_list):
        if perm_name in PA_list[count]:
            PA_list.pop(count)
            count -= 1
        count += 1
        
    for key, key_list in second_dict.items():
        if perm_name in key_list[-1]:
            key_list[-1].remove(perm_name)

# Adds attributes to a specific permission, creates a new PA entry, and updates the dictionary
def add_at_to_perm(*argv):
    
    good_luck = []
    temp = []
    count = 0
    while count != len(argv):
        temp.append(argv[count])
        count += 1
        
    this_count = 0
    while this_count != len(temp) - 1:
        big = []
        big.append(temp[this_count+1])
        this_count += 1
        big.append(temp[this_count+1])
        this_count += 1
        big.append(temp[0])
        good_luck.append(big)

    for what in good_luck:
        PA_list.append(what)
    
    for key, key_list in second_dict.items():
        hold = 0
        for i in temp:
            
            if temp[hold] in key_list and temp[hold] not in needed_atts:
                if temp[0] not in key_list[-1]:  
                    key_list[-1].append(temp[0])
            hold+=1

# Remove an attribute from a permission in the PA_list and dictionary
def remove_at_from_perm(perm_name, att_name, att_value):
    for i in PA_list:
        if perm_name in i and att_value in i:
            i.remove(att_name)
            i.remove(att_value)
            
    my_count = 0
    for i in needed_atts:
        if att_name in i:
            break
        my_count += 1
        
    for key, key_list in second_dict.items():
        if perm_name in key_list[-1] and att_value in key_list[my_count]:
            key_list.pop(my_count)

# Adds and attribute to an entity, creates a new AA entry and updates the dictionary
def add_att_to_ent(ent_name, att_name, att_value):
    ap_list = [ent_name, att_name, att_value]
    AA_list.append(ap_list)
    for key, key_list in second_dict.items():
        if key == ent_name:
            count = -1
            for items in key_list:
                count += 1
                if items == att_name:
                    key_list[count] = att_value
                    break
# Removes an attribute from an entity, removes the AA entry and updates the dictionary
def remove_att_from_ent(ent_name, att_name, att_value):
    count = -1
    for i in AA_list:
        count += 1
        if ent_name in i and att_name in i and att_value in i:
            break
    AA_list.pop(count)

    att_count = -1
    while att_count != len(needed_atts):
        att_count += 1
        if att_name == needed_atts[att_count]:
            break
     
    for key, key_list in second_dict.items():
        if ent_name in key:
            key_list[att_count] = needed_atts[att_count]
             
temp = 2
my_list = []
command_list = ['check-permission', 'add-entity', 'remove-entity', 'add-attribute', 'remove-attribute', 'add-permission', 'remove-permission', 'add-attributes-to-permission', 'remove-attribute-from-permission', 'add-attribute-to-entity', 'remove-attribute-from-entity'] 
# While loop that eats up commands and calls respective functions
while temp < len(user_hold):
    if user_hold[temp] == 'check-permission':
        check_permission(user_hold[temp+1],user_hold[temp+2],user_hold[temp+3],user_hold[temp+4])
    elif user_hold[temp] == 'add-entity':
        add_entity(user_hold[temp+1])
    elif user_hold[temp] == 'remove-entity':
        remove_entity(user_hold[temp+1])
    elif user_hold[temp] == 'add-attribute':
        add_attribute(user_hold[temp+1], user_hold[temp+2])
    elif user_hold[temp] == 'remove-attribute':
        remove_attribute(user_hold[temp+1])
    elif user_hold[temp] == 'add-permission':
        add_permission(user_hold[temp+1])
    elif user_hold[temp] == 'remove-permission':
        remove_permission(user_hold[temp+1])
    elif user_hold[temp] == 'add-attributes-to-permission':
        while user_hold[temp] != 'check-permission':
            if user_hold[temp+1] in command_list:
                break                
            my_list.append(user_hold[temp+1])           
            temp += 1
        add_at_to_perm(*my_list)
    elif user_hold[temp] == 'remove-attribute-from-permission':
        remove_at_from_perm(user_hold[temp+1], user_hold[temp+2], user_hold[temp+3])
    elif user_hold[temp] == 'add-attribute-to-entity':
        add_att_to_ent(user_hold[temp+1], user_hold[temp+2], user_hold[temp+3])
    elif user_hold[temp] == 'remove-attribute-from-entity':
        remove_att_from_ent(user_hold[temp+1], user_hold[temp+2], user_hold[temp+3])     
    
    temp += 1
