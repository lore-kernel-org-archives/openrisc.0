From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Tue, 4 Jan 2022 09:05:28 -0300
Subject: [OpenRISC] [PATCH v4 04/13] or1k: startup and dynamic linking
 code
In-Reply-To: <YdO6GmOcafGR1t9Z@antec>
References: <20211229044251.2203653-1-shorne@gmail.com>
 <20211229044251.2203653-5-shorne@gmail.com>
 <152802e5-0bac-e450-3898-016fc00bdd4f@linaro.org> <YdOir8IbYTzs/Opy@antec>
 <YdO6GmOcafGR1t9Z@antec>
Message-ID: <d3679ca1-8632-1b15-e54e-4c42fddae5dd@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 04/01/2022 00:08, Stafford Horne wrote:
> On Tue, Jan 04, 2022 at 10:28:15AM +0900, Stafford Horne wrote:
>> On Mon, Jan 03, 2022 at 03:17:15PM -0300, Adhemerval Zanella wrote:
>>>
>>>
>>> On 29/12/2021 01:42, Stafford Horne via Libc-alpha wrote:
>>>> +/* Return nonzero iff ELF header is compatible with the running host.  */
>>>> +static inline int __attribute__ ((unused))
>>>> +elf_machine_matches_host (const Elf32_Ehdr *ehdr)
>>>> +{
>>>> +  return ehdr->e_machine == EM_OPENRISC;
>>>> +}
>>>> +
>>>> +static inline Elf32_Addr *
>>>> +or1k_get_got (void)
>>>> +{
>>>> +  Elf32_Addr *got;
>>>> +
>>>> +  asm ("l.jal    0x8\n"
>>>> +       " l.movhi %0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\n"
>>>> +       "l.ori    %0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\n"
>>>> +       "l.add    %0, %0, r9\n"
>>>> +       : "=r" (got) : : "r9");
>>>
>>>
>>> I think this requires a "memory" clobber.
>>
>> Why would it?  This does not do any memory loads or stores.
>>
>> Let me test with "memory" clobber and see what the difference is.
> 
> If seem that with the "memory" clobber the compiler can no longer optimize away
> calling or1k_get_got the second time in elf_machine_load_address.
> 
> I will leave it out unless there is a good reason for it.

Fair enough, I had the impression it does access memory but it seems it
just my lack of or1k assembly knowledge. Sorry for the noise.
