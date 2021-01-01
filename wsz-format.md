WMP WSZ Format  
Copyright © 2017-2020 Tim De Baets. All rights reserved.  
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

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<named element ID (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `<name (zero-terminated Unicode string)>` `<attributes>`

Named element ID can be either `0x00` or `0x03`. ID `0x03` seems to be used exclusively for elements named `BUTTONELEMENT`; all other elements always seem to have an ID of `0x00`.

CLSID element
-------------

`<relative offset of next element (word)>` `<relative offset of first subelement (word)>` `<CLSID element ID (byte)>` `<#subelements (byte)>` `<#attributes (byte)>` `00 00` `<CLSID>` `<attributes>`

There doesn't seem to be a single CLSID element ID, but all such IDs have been ORed with a bitmask of `0x80`.

Most CLSIDs can be found in the type library in `wmp.dll`. Some internal CLSIDs are not in this type library, but can still be found in `HKEY_LOCAL_MACHINE\Software\Microsoft\MediaPlayer\Objects`. While the type library doesn't contain these internal CLSIDs, it does in fact contain the (main) interface that these CLSIDs implement. The internal CLSIDs that are used in WSZ skins, together with the interface that they implement, are listed here:

| Object     | CLSID                                  | Interface         | IID                                    |
| ---------- | -------------------------------------- | ----------------- | -------------------------------------- |
| browser    | {8856F961-340A-11D0-A96B-00C04FD705A2} | HTMLView_Browser? | ?                                      |
| plugin     | {AA1AC37B-49A8-4B41-AF69-B0176C5FFC33} | IWMPPluginUIHost  | {5D0AD945-289E-45C5-A9C6-F301F0152108} |
| Skinlist   | {A8A55FAC-82EA-4BD7-BD7B-11586A4D99E4} | IWMPSkinList      | {8CEA03A2-D0C5-4E97-9C38-A676A639A51D} |
| taskcenter | {395BF287-6477-495F-8427-2C09A23C3248} | ITaskCntrCtrl     | {891EADB1-1C45-48B0-B704-49A888DA98C4} |

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
| `0x88`          | JScript             | (zero-terminated Unicode string)

`wmpprop:` attribute
--------------------

`wmpprop:` is a [listening attribute](https://msdn.microsoft.com/en-us/library/windows/desktop/dd563797(v=vs.85).aspx).

`addend` is a 4-byte integer that is added to the attribute referenced in `attribute value`. This integer can be negative, resulting in a subtraction.

### Named

`<relative offset of next attribute (word)>` `0x40` `<addend (integer)>` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`

### Unnamed

* `<relative offset of next attribute (word)>` `0x48` `<addend (integer)>` `<dispid (word)>` `00 00` `<attribute value (zero-terminated Unicode string)>`

* `<relative offset of next attribute (word)>` `0xC8` `<addend (integer)>` `<dispid (word)>` `00 00` `<attribute value (zero-terminated Unicode string)>`

It's not clear yet what the exact difference between these two types is.

Named attribute
---------------

`<relative offset of next attribute (word)>` `0x00` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`

Named attribute (event)
-----------------------

`<relative offset of next attribute (word)>` `0xE0` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`

Named attribute (JScript)
-------------------------------------------

`<relative offset of next attribute (word)>` `0x80` `<unknown 2-byte integer>` `<attribute name (zero-terminated Unicode string)>` `<attribute value (zero-terminated Unicode string)>`
