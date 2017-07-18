WMP WSZ Format  
Copyright © 2017 Tim De Baets. All rights reserved.  
For conditions of distribution and use, see [LICENSE](LICENSE).  

Predefined element
------------------

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<element ID (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `00 00` `<attributes>`

| Element ID  | Element |
| ----------- | ------- |
| `0x0B`      | theme   |
| `0x0C`      | view    |
| `0x0D`      | subview |

Named element
-------------

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<unknown ID? (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `<name (zero-terminated Unicode string)>` `<attributes>`

CLSID element
-------------

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<CLSID element ID>` `<#subelements (byte)>` `<#attributes (byte)>` `00 00` `<CLSID>` `<attributes>`

Possible CLSID element IDs: `0x82` `0x87` `0x88`

Unnamed attribute
-----------------

`<relative offset of next attribute (word)>` `<attribute type (byte)>` `<dispid (word)>` `00 00` `<attribute value>`

| Attribute type  | Value data type     | Size
| --------------- | ------------------- | ----
| `0x01`          | Boolean             | 2 bytes
| `0x04`          | Integer             | 4 bytes
| `0x08`          | String              | (zero-terminated Unicode string)
| `0x18`          | Resourcestring (ID) | 4 bytes
| `0x28`          | `wmpenabled:`       | (zero-terminated Unicode string)
| `0x0D`          | SYSINT              | (zero-terminated Unicode string)
| `0x88`          | Global variable     | (zero-terminated Unicode string)

`wmpprop:` attribute
--------------------

`<relative offset of next attribute (word)>` `48 00 00 00 00` `<dispid (word)>` `00 00` `<attribute value (zero-terminated Unicode string)>`

Named attribute
---------------

`<relative offset of next attribute (word)>` `00` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`

Named attribute (event)
-----------------------

`<relative offset of next attribute (word)>` `E0` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`
