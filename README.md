<div align='center'>
<img src='Assets/comprs.svg' />
</div>

ComPrS
======
This is a small module for compressing text in Powershell.  It's not intended for creating compressed files, though what you do with the string output is up to you.

## Getting Started

### Installing ComPrS
Install from the PowerShell Gallery
```Powershell
PS> Install-Module -Name 'ComPrS'
```

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

The included function `ConvertTo-HereString` can help when trying to include compressed string text inside an existing .ps1 file.  Compress-String produces a single long string representing the compressed data.  If the original data was a few thousand lines of text that can be a very long string, pushing the scroll bar of your IDE way off to the side.  To simplify getting it in to a here-string format you can take the output from Compress-String and convert it with ConvertTo-HereString.

Using the IP reference from before, say we have the 65534 IP addresses and the data looks like this:
```
10.0.0.1
10.0.0.2
10.0.0.3
10.0.0.4
10.0.0.5
10.0.0.6
10.0.0.7
10.0.0.8
10.0.0.9
10.0.0.10
10.0.0.11
10.0.0.12
10.0.0.13
10.0.0.14
10.0.0.15
10.0.0.16
...
```
And so on.  If we compress these with Compress-String the output string is over 189k characters long.
```
VN1NqhyLsqTRfkFN5ZBmHr/zn1i9R6HtK7hwiY5kKWnHl35aK7///vd/+b//J///qX9P8/d0/D2df0/X39P99/T8Pb1/T/nt465kZ...
```
To get a more vertical look to the data we can convert it in to a here-string.
```Powershell
PS> $Compressed = Compress-String -String $IPs
PS> ConvertTo-HereString -String $Compressed
VN1NqhyLsqTRfkFN5ZBmHr/zn1i9R6HtK7hwiY5kKWnHl35aK7///vd/+b//J///qX9P8/d0/D2df0/X39P99/T8Pb1/T/nt465kZ7I72aHsUnYqu5Udy65118qfade6a9217lp3rbvWXeuuza7Nrg1/hbs2uza7
Nrs2uza7Nrt27Nqxa8euHfyL7dqxa8euHbt27Nqxa+eunbt27tq5ayc/ILt27tq5a+eunbt27dq1a9euXbt27drFz+OuXbt27dq1a/eu3bt279q9a/eu3bt28+O/a/eu3bv27Nqza8+uPbv27Nqza8+uPbxtu/bs
2rtr7669u/bu2rtr7669u/bu2svL7dvN6/3j/f7xgv94w3+84j/e8R8v+Y+3/Mdr/mP3kxV2DYtlMS22xbhYF/NCX0JgUnvGLo0JkQmVCZkJnQmhCaUJqQmtyRhSdslN6E0ITihOSE5oTohOqE7ITg4Lzi7lCekJ
7QnxCfUJ+Qn9CQEKBcrpVwe7RChUKGQodCiEKJQopCi0KMQol99Z7NKjEKRQpJCk0KQQpVClkKXQpdx+WbJLmkKbQpxCnUKeQp9CoEKhQqLy+C3NLpUKmQqdCqEKpQqpCq0KsQq1yut54H3AgUCvSq9Kr0qvSq9K
r0qvSq9KrxoPE3bpVelV6VXpVelV6VXpVb2HPIg+FxG73kQeRV5FnkXeRR5G9Kr0qvSq4ynGLr0qvSq9Kr0qvSq9Kr0qvSq96uENyC69Kr0qvSq9Kr0qvSq9Kr0qverp8flvN//9/p7y99S/p/l7Ov6e9tdef0/3
39Pz9/Tu78zIrmRnsjvZoexSdiq7lR3LrnXXyp9p17pr3bXuWnetu9Zd667Nrs2uDX+Fuza7Nrs2uza7Nrs2u3bs2rFrx64d/Ivt2rFrx64du3bs2rFr566du3bu2rlrJz8gu3bu2rlr566du3bt2rVr165du3bt
2sXP465du3bt2rVr967du3bv2r1r967du3bz479r967du/bs2rNrz649u/bs2rNrz649vG279uzau2vvrr279u7au2vvrr279u7ay8vt283r/eP9/vGC/3jDf7ziP97xHy/5j7f8x2v+Y/eTFXYNi2UxLbbFuFgX
80JfQmBSe8YujQmRCZUJmQmdCaEJpQmpCa3JGFJ2yU3oTQhOKE5ITmhOiE6oTshODgvOLuUJ6QntCfEJ9Qn5Cf0JAQoFyulXB7tEKFQoZCh0KIQolCikKLQoxCiX31ns0qMQpFCkkKTQpBClUKWQpdCl3H5Zskua
QptCnEKdQp5Cn0KgQqFCovL4Lc0ulQqZCp0KoQqlCqkKrQqxCrXK63ngfcCBQK9Kr0qvSq9Kr0qvSq9Kr0qvGg8TdulV6VXpVelV6VXpVelVvYc8iD4XEbveRB5FXkWeRd5FHkb0qvSq9KrjKcYuvSq9Kr0qvSq9
Kr0qvSq9Kr3q4Q3ILr0qvSq9Kr0qvSq9Kr0qvSq96unx+W+3fxd5/y7y/l3k/bvI+3eR97/9tdff0/339Pw9vfs7M7Ir2ZnsTnYou5Sdym5lx7Jr3bXyZ9q17lp3rbvWXeuudde6a7Nrs2vDX+Guza7Nrs2uza7N
rs2uHbt27Nqxawf/Yrt27Nqxa8euHbt27Nq5a+eunbt27trJD8iunbt27tq5a+euXbt27dq1a9euXbt28fO4a9euXbt27dq9a/eu3bt279q9a/eu3fz479q9a/euPbv27Nqza8+uPbv27Nqzaw9v2649u/bu2rtr
7669u/bu2rtr7669u/bycvt283r/eL9/vOA/3vAfr/iPd/zHS/7jLf/xmv/Y/WSFXcNiWUyLbTEu1sW80JcQmNSesUtjQmRCZUJmQmdCaEJpQmpCazKGlF1yE3oTghOKE5ITmhOiE6oTspPDgrNLeUJ6QntCfEJ9
Qn5Cf0KAQoFy+tXBLhEKFQoZCh0KIQolCikKLQoxyuV3Frv0KAQpFCkkKTQpRClUKWQpdCm3X5bskqbQphCnUKeQp9CnEKhQqJCoPH5Ls0ulQqZCp0KoQqlCqkKrQqxCrfJ6HngfcCDQq9Kr0qvSq9Kr0qvSq9Kr
...
```
The width can be controlled with the `-Width` parameter for your preference. The default is 160 characters wide.  This can then be stored in a PowerShell script as a here-string and then expanded back in to plaintext using Expand-String later.

## Made With Sampler
This project was made using [Sampler Module](https://github.com/gaelcolas/Sampler)
See their [video presentation](https://youtu.be/tAUCWo88io4?si=jq0f7omwll1PtUsN) from the PowerShell summit for a great demonstration.