From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 9 Mar 2018 16:47:23 +0100
Subject: [OpenRISC] [RFC PATCH 6/6] arch: add untagged_addr definition
	for other arches
In-Reply-To: <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
 <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
Message-ID: <CAAeHK+y=_imh4uNSAg_vj3DLAeDLcVP3a4f79dNMW=Ot5oLiZQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 9, 2018 at 3:16 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/03/18 14:02, Andrey Konovalov wrote:
>>
>> To allow arm64 syscalls accept tagged pointers from userspace, we must
>> untag them when they are passed to the kernel. Since untagging is done in
>> generic parts of the kernel (like the mm subsystem), the untagged_addr
>> macro should be defined for all architectures.
>
>
> Would it not suffice to have an "#ifndef untagged_addr..." fallback in
> linux/uaccess.h?
>

Hi Robin!

This approach is much better, I'll try it. This will also solve the
merge issues that Arnd mentioned.

Thanks!
