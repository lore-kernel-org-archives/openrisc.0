From: H. Peter Anvin <hpa@zytor.com>
Date: Sat, 25 Aug 2018 21:56:11 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
Message-ID: <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/25/18 20:16, H. Peter Anvin wrote:
> On 08/25/18 19:38, H. Peter Anvin wrote:
>>
>> If it was worthwhile it would make more sense to at least force this
>> into the rodata section with the string, something like the attached
>> file for an example; however, I have a hunch it doesn't matter.
>>
> 
> An even nuttier version which avoids the extra pointer indirection.
> Read it and fear.
> 
> 	-hpa
> 

OK, so one more thing, I guess: it is necessary to suppress the tailcall
optimization for _RET_IP_ to make any sense, but that should be pretty
simple:

static inline void notailcall(void)
{
	asm volatile("");
}

	-hpa
