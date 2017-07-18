WMP WSZ Format  
Copyright © 2017 Tim De Baets. All rights reserved.  
For conditions of distribution and use, see [LICENSE](LICENSE).  

Predefined element
------------------

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<element ID (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `00 00` `<attributes>`

### Known element IDs

| ID    | element |
| ----- | ------- |
| 0x0B  | theme   |
| 0x0C  | view    |
| 0x0D  | subview |

Named element
-------------

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<unknown ID? (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `<name (zero-terminated Unicode string)>` `<attributes>`

