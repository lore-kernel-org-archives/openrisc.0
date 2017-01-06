From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 6 Jan 2017 22:50:34 +0200
Subject: [OpenRISC] [PATCH v2 4/7] x86: put msr-index.h in uapi
In-Reply-To: <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <CAHp75VdDfopdSy-7oy87ZeosDB9+FN4zFBhErPWLQB7tH81zTw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jan 6, 2017 at 11:43 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> This header file is exported, thus move it to uapi.

Just hint for the future:
-M (move)
-C (copy)
-D (delete) [though this is NOT for applying]

-- 
With Best Regards,
Andy Shevchenko
