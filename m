From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 9 Mar 2018 18:58:00 +0100
Subject: [OpenRISC] [RFC PATCH 0/6] arm64: untag user pointers passed to
	the kernel
In-Reply-To: <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
References: <cover.1520600533.git.andreyknvl@google.com>
 <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
Message-ID: <CAAeHK+xTEp-jcMDxNK4kCKcNtVbu4s4VXxzThsKMMFaTdBv0RQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 9, 2018 at 3:15 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Andrey,
>
> On 09/03/18 14:01, Andrey Konovalov wrote:
>>
>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
>> tags into the top byte of each pointer. Userspace programs (such as
>> HWASan, a memory debugging tool [1]) might use this feature and pass
>> tagged user pointers to the kernel through syscalls or other interfaces.
>
>
> If you propose changing the ABI, then
> Documentation/arm64/tagged-pointers.txt needs to reflect the new one, since
> passing nonzero tags via syscalls is currently explicitly forbidden.
>
> Robin.

Hi Robin!

I will include changes to Documentation/arm64/tagged-pointers.txt in
the next version.

Thanks!
