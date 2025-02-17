<div align='center'>
<img src='Assets/comprs.svg' />
</div>

ComPrS
======  

**WORK IN PROGRESS**  

This is a small module for compressing text in Powershell.  It's not intended for creating compressed files, though what you do with the string output is up to you.  

## Getting Started  

### Installing ComPrS  
*soon*. Not currently published to the PS Gallery.  
  
## Use & Examples  
Sometimes it's necessary to leverage accompanying files with a Powershell script.  Maybe this is a CSV that will be used to loop through, or a text file for the same purpose or maybe you need to validate something against the contents of the text file.  For portability it can be very handy to have everything right in the Powershell script, though sometimes this can be quite long.  
As an example, say you have a long list of hash values you're going to compare against:  
```
356A192B7913B04C54574D18C28D46E6395428AB
DA4B9237BACCCDF19C0760CAB7AEC4A8359010B0
77DE68DAECD823BABBB58EDB1C8E14D7106E83BB
1B6453892473A467D07372D45EB05ABC2031647A
AC3478D69A3C81FA62E60F5C3696165A4E5E6AC4
C1DFD96EEA8CC2B62785275BCA38AC261256E278
902BA3CDA1883801594B6E1B452790CC53948FDA
FE5DBBCEA5CE7E2988B8C69BCFDFDE8904AABC1F
0ADE7C2CF97F75D009975F4D720D1FA6C19F4897
B1D5781111D84F7B3FE45A0852E59758CD7A87E5
17BA0791499DB908433B80F37C5FBC89B870084B
7B52009B64FD0A2A49E6D8A939753077792B0554
BD307A3EC329E10A2CFF8FB87480823DA114F8F4
FA35E192121EABF3DABF9F5EA6ABDBCBC107AC3B
F1ABD670358E036C31296E66B3B66C382AC00812
1574BDDB75C78A6FD2251D61E2993B5146201319
...
```  
If this is only a couple dozen lines it's not that big of a deal.  But if it's thousands of lines it's a lot of vertical space taken up by hash strings.  Compressing all of them with Compress-String saves about 70k characters, but it's still around 140k characters total so not small by any means. In terms of bytes its 70 bytes removed from 206.  
This example is using hash strings which do not compress very well since they're all unique.  A list of 65534 unique IP addresses represents around 841KB of data, but when compressed with Compress-String it's now only 52KB.  
