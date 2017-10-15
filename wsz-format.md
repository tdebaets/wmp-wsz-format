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

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<CLSID element ID (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `00 00` `<CLSID>` `<attributes>`

There doesn't seem to be a single CLSID element ID, but all such IDs have been ORed with a bitmask of `0x80`.

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

`wmpprop:` is a [listening attribute](https://msdn.microsoft.com/en-us/library/windows/desktop/dd563797(v=vs.85).aspx).

### Named

`<relative offset of next attribute (word)>` `0x40` `<unknown 4-byte integer>` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`

### Unnamed

`<relative offset of next attribute (word)>` `0x48` `<unknown 4-byte integer>` `<dispid (word)>` `00 00` `<attribute value (zero-terminated Unicode string)>`

Named attribute
---------------

`<relative offset of next attribute (word)>` `0x00` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`

Named attribute (event)
-----------------------

`<relative offset of next attribute (word)>` `0xE0` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`
