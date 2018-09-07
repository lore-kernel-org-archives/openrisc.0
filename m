From: Rob Herring <robh@kernel.org>
Date: Fri, 7 Sep 2018 08:58:41 -0500
Subject: [OpenRISC] [PATCH 00/21] DT cpu node iterator
In-Reply-To: <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
References: <20180905193738.19325-1-robh@kernel.org>
 <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
Message-ID: <CAL_JsqLvLoekvxcaBMxrboJzqS=NyB69NHLShos+LhETj7zNwQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 7, 2018 at 7:54 AM Michal Simek <monstr@monstr.eu> wrote:
>
> Hi Rob,
>
> 2018-09-05 21:37 GMT+02:00 Rob Herring <robh@kernel.org>:
>>
>> This series adds an iterator for cpu nodes and converts users over to use
>> it or of_get_cpu_node in some cases. This allows us to remove the
>> dependency on device_type property for cpu nodes though removing that
>> from DTS files will have to wait for some time. In some cases, this makes
>> the DT search more strict by only looking in /cpus child nodes rather
>> than any node with the device_type == cpu. The iterator also honors the
>> status property which is often forgotten.
>>
>> I've only tested on ARM under QEMU and compiled powerpc.
>
>
>
> Do you have this somewhere in your tree not to apply 21 patches by hand?

Yes, dt/cpu-type branch on my kernel.org tree.

Rob
