From: BAndViG <bandvig@mail.ru>
Date: Sun, 3 Mar 2019 10:06:44 +0300
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <CAAfxs75VcJa+ngnmFMj9t+ctDe+MBH7EK3d=V3MKm1z5RCvkfg@mail.gmail.com>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
 <37FCFC974D464083BD1071538AD0EAFD@BAndViG>
 <CAF6YiZ6j=GbTG_G-q2=KYf6Nc-kACgGvxbtRMBjaRdQd8oi08A@mail.gmail.com>
 <20190201215417.GY3235@lianli.shorne-pla.net>
 <D036467FCCAF4D23A7566ED09E17825B@BAndViG>
 <CAAfxs74D0J+Gv8dm+8CvYAQtfqUcajUgG4KEb5yKecGmH3aYYA@mail.gmail.com>
 <CAAfxs77fPShv0kkkmzkSYJB5-eWTwwaaR66kdu8Gq+6Eabhxtg@mail.gmail.com>
 <4DE8EEDE0F6B43CC8CEDE95B8CF2CF29@BAndViG>
 <CAAfxs75VcJa+ngnmFMj9t+ctDe+MBH7EK3d=V3MKm1z5RCvkfg@mail.gmail.com>
Message-ID: <C58B5BD730794196B2098680FC08F373@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Thanks, Stafford. Now it works. I've pushed my update.

As I'm not familiar with ordinary OpenRISC verification environment I've left 
monitor related things for you.
I see that
`define CPU_WRAPPER `MOR1KX_INST.mor1kx_cpu
could be treated as internals, but MOR1KX_INST itself is obviously not.
As you find free time let's modify monitor in the way you planned.


From: Stafford Horne
Sent: Sunday, March 03, 2019 1:06 AM
To: BAndViG
Cc: Julius Baxter ; Olof Kindgren ; Openrisc ; Philipp Wagner ; Stefan 
Wallentowitz
Subject: Re: [OpenRISC] [RFC] Splitting out Marocchino to new Repo

I think I fixed it.  Can you try again?

On Sun, Mar 3, 2019 at 12:29 AM BAndViG <bandvig@mail.ru> wrote:
>
> I’ve prepared commit with extended Readme.md and extracting some modules into 
> separate files, but I haven’t got access to push it (permission denied).
>
> -Andrey
>
> From: Stafford Horne
> Sent: Saturday, March 02, 2019 11:36 AM
> To: BAndViG
> Cc: Julius Baxter ; Olof Kindgren ; Openrisc ; Philipp Wagner ; Stefan 
> Wallentowitz
> Subject: Re: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
>
> Hello,
>
> I worked or1k_marocchino to the openrisc org.  You sold have access too.
>
> -stafford
>
> On Fri, Mar 1, 2019, 8:33 AM Stafford Horne <shorne@gmail.com> wrote:
>>
>> Hello,
>>
>>
>>
>> On Wed, Feb 27, 2019, 4:25 AM BAndViG <bandvig@mail.ru> wrote:
>>>
>>> Hi all
>>>
>>> I've created MAROCCHINO new repo under my GitHub account
>>> (https://github.com/bandvig/or1k_marocchino) as a demo version.
>>
>>
>> This looks good.
>>
>>>
>>> Pay attention that monitors still have "mor1kx_" prefix and 
>>> or1k_marocchino_cpu
>>> instance still called "mor1kx_cpu" to maintain compatibility with current
>>> verification infrastructure.
>>
>>
>> I think we can change this now. As long as we have:
>>
>> bench/verilog/mor1kx_monitor
>>
>> We can define internals as we like.  Before we we're trying to share so we 
>> needed to use the same name.
>>
>>
>>>
>>> Please, make comments and proposals.
>>
>>
>> Some comments.
>> - let's put a style guide in the readme
>> - can we split modules to separate files? I.e. or1k_marocchino_execute.v and 
>> or1k_marocchino_oman.v have some interesting modules I think would make 
>> sense to be on their own for.  Not everything needs to be split , but at 
>> least each execution unit and the RAT modules.
>>   - I created a diagram on the pipeline dependencies. You then explained 
>> some things  more clearly.  I'll try to put it on the wiki or in the repo.
>>
>>>
>>> I'm planning to continue development in the repo as its structure will be
>>> approved. Btw, I'm not sure that it should be forked into OR organization. 
>>> I
>>> think it would be clearer to create new repo and fill it. I could do that 
>>> by
>>> myself If I've got write access to OR organization account (not sure). Or
>>> anybody welcome to do that.
>>
>>
>> I think having it the openrisc org repo would be good.  Let me see if I can 
>> clone it in and give you access.  If not I'll ask for help.
>>
>> -stafford

WBR
Andrey 

