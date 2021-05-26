From: Stafford Horne <shorne@gmail.com>
Date: Wed, 26 May 2021 21:15:50 +0900
Subject: [OpenRISC] Error found in mor1kx cache lru
In-Reply-To: <CADGJwMzHeO13bW0i7JFGGtJRcUpGcPW+WxNzqKXRDWLLPFv-eA@mail.gmail.com>
References: <CADGJwMzHeO13bW0i7JFGGtJRcUpGcPW+WxNzqKXRDWLLPFv-eA@mail.gmail.com>
Message-ID: <YK479iP+xMY8Nucx@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

+CC list

Hi Harshita,

Thanks for reporting, could you also open a github issue with the
same details at:

 https://github.com/openrisc/mor1kx/issues

-Stafford

On Wed, May 26, 2021 at 02:52:11PM +0530, Harshitha S wrote:

> 
>      NUMWAYS = 4
>      current = 6'b110100;
>      access  = 4'b0010;
>    
>     This current history is:
>    
>       0<1 0<2 0<3 1<2 1<3 2<3
>       0   0   1   0   1   1
>     
>      History of access => 3>0>1>2
>      Access request is for 1, then expected order is 1>3>0>2.
>      Expected values of lru_post = 1 and lru_pre = 2
>  
> Initial expand matrix based on current history
> 
>         0     1      2      3         0 1 2 3
>    0    1    (0<1)  (0<2)  (0<3)    0 1 0 0 1
>    1  (1<0)    1    (1<2)  (1<3) => 1 1 1 0 1
>    2  (2<0)  (2<1)    1    (2<3)    2 1 1 1 1
>    3  (3<0)  (3<1)  (3<2)    1      3 0 0 0 1
> 
> lru_pre is AND of bits in a row
> 
> When request access=4'b0010 then 1st row of expand matrix is 
> replaced with zeros and 1st column of expand matrix is replaced 
> with 1.
> 
>      
>      
> The matrix changes accordingly
>       
>          0 1 2 3      0 1 2 3
>        0 1 0 0 1    0 1 1 0 1
>        1 1 1 0 1 => 1 0 1 0 0
>        2 1 1 1 1    2 1 1 1 1
>        3 0 0 0 1    3 0 1 0 1
> 
> lru_post is product of bits in a column
> 
> update = 6'b100101
> 
> This means updated history is
> 
>  0<1 0<2 0<3 1<2 1<3 2<3
>   1   0   1   0   0   1
> 
> This is what we interpret from output 1>3>0>2 and its same as our expectation.
> 
>    





