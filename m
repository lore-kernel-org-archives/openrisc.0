From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 May 2021 05:58:35 +0900
Subject: [OpenRISC] Error found in mor1kx cache lru
In-Reply-To: <CADGJwMzHeO13bW0i7JFGGtJRcUpGcPW+WxNzqKXRDWLLPFv-eA@mail.gmail.com>
References: <CADGJwMzHeO13bW0i7JFGGtJRcUpGcPW+WxNzqKXRDWLLPFv-eA@mail.gmail.com>
Message-ID: <CAAfxs75w_+9R_87uz6i0pkahaydzR7+if4JqRRQ5s_feZhVLgQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

The github issue was added here:

https://github.com/openrisc/mor1kx/issues/119

Harshita thanks for you investigation and starting early on GSoC you
are already getting into some interesting parts.

On Wed, May 26, 2021 at 6:21 PM Harshitha S
<harshithasridhar172000@gmail.com> wrote:
>
> Hello Sir,
>
> I'm Harshitha, I was looking into the formal verification of mor1kx's cache LRU module and I found a bug there.
>
> I was expecting that the variable access request would be the new lru_post value, but it's not the case. lru_post is calculated as AND of rows but I think it has to be considered as AND of columns. I considered the same example as per your description, wrote a test bench to verify it. I got different update variable values that the code functionally executes. I corrected the code by modifying the lru_post computation, then I was able to get the access same as the lru_post.

I think its not correct, the lru_post is the least recently used from
history.  The access request is the "most recently used", so it will
not be in lru_post.

>
> I came across another unusual thing. In the code snippet where the expand matrix is updated, the row number for exchange is not computed before because of which the last row of the expand matrix is considered as one bit less by the formal tool. You can check the expand_error image for this error where the third row of the matrix has only 3 bits instead of 4.  I tried to precompute the row number for exchange then I didn't face this error. You can look into no_expand_error  where this issue was resolved.
>

That sounds strange, can you post a PR for this change?  or a patch
using 'git diff` its easier to explain code changes using patches.

> I request you to look into this error. Let me know what you think.
>
> Regards
> -Harshitha
>
