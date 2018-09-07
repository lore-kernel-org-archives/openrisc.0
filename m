From: Michal Simek <monstr@monstr.eu>
Date: Fri, 7 Sep 2018 14:54:20 +0200
Subject: [OpenRISC] [PATCH 00/21] DT cpu node iterator
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Message-ID: <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Rob,

2018-09-05 21:37 GMT+02:00 Rob Herring <robh@kernel.org>:

> This series adds an iterator for cpu nodes and converts users over to use
> it or of_get_cpu_node in some cases. This allows us to remove the
> dependency on device_type property for cpu nodes though removing that
> from DTS files will have to wait for some time. In some cases, this makes
> the DT search more strict by only looking in /cpus child nodes rather
> than any node with the device_type == cpu. The iterator also honors the
> status property which is often forgotten.
>
> I've only tested on ARM under QEMU and compiled powerpc.
>


Do you have this somewhere in your tree not to apply 21 patches by hand?

Thanks,
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180907/4c63e825/attachment.html>
