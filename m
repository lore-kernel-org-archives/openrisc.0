Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021097.outbound.protection.outlook.com [40.107.192.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C2136E09
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178258; cv=fail; b=bmGicmI7/KykX3O2iODsryE+0IbNRkrUekXj3fH/Dmt1E2l8LEEwW3SJ+12ACRN/ARKLtH5SDULhwJ8eD7GwK20hdKw7THWt8Ohco+V+BPSLK5ZmVe72lvJjHZu4qRt0TBj9kMiyoOGQto/1m1J2GyMzUUjMWS/mniBGHtntGq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178258; c=relaxed/simple;
	bh=qs6yuP8rG9TXjBUzleupjul0p2VD+EX71cXDlOGcUyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iz43d/oEOrIxNwV+C1PUYxPbg1m+X58sal4+v8qrIK7+KQAKqHIM+w03+1UI59MBxL7wRaBKX2xWqhvloh6LVNdocQ943nLB4r0OKmIQOCWE0IkyzS8xTIkAbv0YHrxO85DECKfClFdTR0kn3294ZQ+DXm5ErIkPVR2fWGGfjl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TQ0xSgV3; arc=fail smtp.client-ip=40.107.192.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TQ0xSgV3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ohe4E9bmnt4HAtOFB1ajqRSlv4e2xTIa4ioAjohOaC7x9pqHtjvjkxkhwBigTWGrhSSouMk1i0ATLME5lC5SRnpX5xuu0WJ4HOsZCJ/Qz1meUGkMbrmIRHshAJtCYrwedoYj4Dv3kf2eVTvFatcOCzI35GpUq1j5N8HJicT/HhJYa1uR/JA7HV4FRkti2DNaXjAYRZ9DjT88kjwKh5GT2bkjiw4g3fsIBwDfKlZj7y181XE1IjsdWjGYgmaa8B6xuADzNFgk3Me9bcYtan7J2M6MXJa2BDZxJvlVjAxj10n/7fVW4Z02tuN15RrSMOFiUx2h5amXW3DW+zaiEGUUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs0YgsKzETFtDbwD38gzrJpD0xFDFR4hw7IsUzzyDYQ=;
 b=CIsaj38yeCWplBuY+TDh8cdvWlAh0+gMWRHOe4Bq6lt7ErQJ6q/z6b/G7KWpYBOK0X8SgoHcq8GD8e9/f+7e+x08oQl04v0C4nkNSHlWBflyiD2CmS8SqGupuCMvtGmLkkxSdp3FbQtSkdmrSnjw7KyUS5boTXhYcO6GOtD8kknEHjcTe5UNADxnXQ3zPZHBjsINnZZV+rmdNiYl3BAjD0yfDhfqWnjuGZv0WORzti+HZBBiSYCz+irCdB5G9e/Po8XvmSAUUPZTRT4XgMPCu1wFOxjCero2heon0OfRvHKgOmTxWqW05C++v4hAKakLNUCoOsJbji7cInYQNKx6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs0YgsKzETFtDbwD38gzrJpD0xFDFR4hw7IsUzzyDYQ=;
 b=TQ0xSgV3FAuP5gT899LOeLuREtozgtLvDZGVUlC85k08pEN0u1hycWgoCEirCNDa3CY0HnSzHiEyv2KyeCZuGAwY7NuDKykrgd0SPxIfl0yxCC94FdLytV4wWi6m7QikAef2hWWHylYSF2rSInZTqo9px8rXy0vex5p4TQhk9sWDB40SLprZET0cF/q5iVy2qgMOrDgUF5r43/zIEImkF1KRfqMAeIaH1I8lS3ynQvlI9X+sX6g7uCg6FTUfzwuhAZevGhCZXRVqIY/T1ENDPaZOhYM9r4sAhRs8aDEECvzfVU3EzZDOL+q2lL0oG5fJrx2CbSzY1U1wuZoCtt3RgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB8856.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 15:44:14 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 15:44:14 +0000
Message-ID: <41177d42-adcb-496f-9f33-d30945c02447@efficios.com>
Date: Mon, 6 Jan 2025 10:44:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 GLIBC patches <libc-alpha@sourceware.org>
References: <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec> <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com> <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com> <Z11l_-7RV07JRwCo@antec>
 <Z2sXcENuw--JWlx6@antec> <Z3XnAt7z1xWermeI@antec> <Z3orL1GN8DjVRQiT@antec>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: en-CA
In-Reply-To: <Z3orL1GN8DjVRQiT@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::17) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbbb84e-11cd-4eec-cd73-08dd2e68f8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N05JVER6VTZSZk9pZUIwbmJVa05YLy95ZW83bHdyeU14MGY2NWtqaW1LdCtQ?=
 =?utf-8?B?UVdlVXMwUjl2KzYrTXVrQkpUZ2xTTmNSSWFlMjhYcWZnRXZ0WUJKVmRLWHR4?=
 =?utf-8?B?VEcxOGxFRDBoS2o0K1VqSDN4bWxiemMzN3pLS2llMXZKaHlGRmViT0RDaHlD?=
 =?utf-8?B?OFZCbEMxakY3U3pxSGZRYXNhck51YzZIU213YVRiYzhkSEU2aFpWSmgwRHBu?=
 =?utf-8?B?VWQxVGpwTXBTaFAvWmxBMEkveFRmVUNndjhyYzlTWFNXYjF3VlFsSG5lMUtv?=
 =?utf-8?B?WEFRLzhuV24zeWY4Wk52ZjBmTDEzQlRVanR6a3lveFZRMW5mK1hWMHJmc1Qx?=
 =?utf-8?B?M2JZYjA1SWMzUlJwbTg5TU5Yb1c2aGcwKzVlMkc0cURqaUg0UHRubE9DWnlt?=
 =?utf-8?B?MXlGOGFlRzdsVmtCNzhGbG1lRjQ4NGMzUEw4Qks3YlN6RWNTczRaQUw4UVJx?=
 =?utf-8?B?cExnOXFNNklCVThIUUFNZmU3elg4aXg2MmNqVUszM0NLOHhucWtBL2FXRkVE?=
 =?utf-8?B?U0dVSVYvTGtCRnhaSHJ0ZlR4R2dSSUg5NzdkSHBod3JSNkFyVDVjZGNOWm1a?=
 =?utf-8?B?M3I4dXkyNXp2bm1XUzF4WmpUd0xMbGsvb3BJamk5a29OVk5ucEwza3Z6UGE3?=
 =?utf-8?B?MEpQTzlLU0ZFb1hUbjhhZkd4dE8zS2p1SHlaU1JRVDF0eUVzOW9CRDNqUzZ0?=
 =?utf-8?B?c3Fib2JmQUh2U0pmY21Id3daTVNvQ0lxL0lIRzRIc0k4c3V3R0c1MkJpZ3pD?=
 =?utf-8?B?bXR1WXhiWDlKT3RTa1pXZDBYVzRlNFVoazkwS0U3ZjJNb2RienBwVFBCY081?=
 =?utf-8?B?VSs2VG9DSktFcWRqS1EzWUFsN1NoZkltbVdHbXRLeTk0L3RJNHNlWUgrVzEw?=
 =?utf-8?B?cW85YTZHdmNZOXVuNWU4WlB0d0tnV2FOUjRheVZvZ1JNczBPcEJWOFFzQnla?=
 =?utf-8?B?MXp1cU5ycVhXVDlYc1czZmpjcmlVa2kxYVBjSE9YbExqQXBFb2l4aHFwcGUy?=
 =?utf-8?B?enByMXIvU3g4QnZYWm9iWFo0VGVvV3VOMm9KSHFWaXFKK2pBU0d4MERvaGt3?=
 =?utf-8?B?anhPRk92b3lBVTZEclJUM2NLd2QwUmZzNElBZ3NzQUVNNU5SNkZhQ2M5bWpZ?=
 =?utf-8?B?NFR1YTdKTWFuT3JZSlJxMVZSMlB5ZU1XNkFLRWIySEVSYzMzZzRhd0VJOSs4?=
 =?utf-8?B?ckNObTArWVhmUm5pZmxDRTJPQlVYTURTWTJVRTIxeENJTjlrZUVzdEsvZXpv?=
 =?utf-8?B?eXE4emdJbHRqQjY1TnhVYnI1d2VNTGxUek03d29lOVRwaWRjRDNmMmd0NVVs?=
 =?utf-8?B?OEZSM0pVRjh2SktIMHZveG02NkkvTk85TUI0RHdEQk9wS2JDcThJVlBXZXRv?=
 =?utf-8?B?Z2ZpL0xXRlJzRVRMSHhSTC9uWEVsSXQyY2V5cmx2ZUpjTmJqQnlEVGRhbU83?=
 =?utf-8?B?dXBmdFFqUjZDa0cya0Z4RHRHZEQvS2hyV3RFdG9mUVBTbWUvWTAvUmlLMDFX?=
 =?utf-8?B?U1cvYjhOMWhJNlhYamtXcW1XNmpyNXEzaWRiVVN4enpuOFRORnBkRXd5VThV?=
 =?utf-8?B?RFMxaHRIVjRIb3NEbEpoSW96VmZ0bVJHWDMrOFEwNDZydmpoR05pSVhMejFZ?=
 =?utf-8?B?TTRqYXJDQ1VEMkt5S2xhUllncFF0aXpFbVFNSms1Z2ZNNkJrT3c2OUd5cUhM?=
 =?utf-8?B?eHdZaXJ2ZGNOaWhMMFh4SkZwcmM0VmFDMkJreVNJNXFSU3JQcGtHODh6blNO?=
 =?utf-8?B?REI3L3N4REJlb0JPOHhDeHQ3Sm1nenhIaTBBWnF3RmNSU29WbnhrbE9ZdnVY?=
 =?utf-8?B?MUlNNHZodFRCOTFMVUlXL3ZqcU5mMHYzUjBadHhodEE4bGZDcUJoc3RGOGd6?=
 =?utf-8?Q?DbCncQ/pfzHbx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNiQXptSzlNeUdFUklGUUhkRytYRG5iZUxaejNTeHFVb09UTlpKWkdjVkxu?=
 =?utf-8?B?TGdOL1Y5SXpwV0NzOHVDYmhPcml1ejdZb0hRVkkwQi9jcGtEZ1BXS0VQeEs1?=
 =?utf-8?B?S3JkR3ZUYjNMcXE0RTF5enRQdEtHMmdScTVoQnBwNkd2UUFPUVhwRklSUHlu?=
 =?utf-8?B?THVNdnZBSVVYb2ZiNSs4MGRhMUZUV05xUDByQTRSV0gzOUdGN1p0Vnc2bFlr?=
 =?utf-8?B?TXpGejZHYUJVRTBvWXZKRWtYOVd5V2tva005TTJaYXJ4Q0p1THR4amRFK0o5?=
 =?utf-8?B?OFB3UGJIaEFEaFJwcElhNFFkcGQ2eXlWc3JVVzc5S0NDRzNCclFiZHo4WStL?=
 =?utf-8?B?YkZhTkNPclJvVEFXeUM5WVJRa1pZaVordzB2alZ0dnhpRnJwQ0NOU0hlcGZJ?=
 =?utf-8?B?RE00OFRGWTZPMDJDUDQ0RFg4ZWt6MkJ5cXJQdk5aR1lNK1Y1a0EvREk4ZERm?=
 =?utf-8?B?RjVWa2g4dlF2Rkl2dGpsUmoyYzNtL2s5dmsyVG1uVVJFZUI1V2c5SlJLaU5R?=
 =?utf-8?B?QXNJU1RPTTZQUW9IVWNyR2c1UlNjN0FHeUhyQ1p0OUtBWDB2SEpNNnc2Qkc3?=
 =?utf-8?B?RzdGSkcrYkVxQnRmVGRybnFsMDdyS1o2cUhwWU9DL2tpVnVEZVdSY0JJcS9G?=
 =?utf-8?B?ajlwWFVnMTEwN0xWUXI4cXQwRnJJU2NCSmVlTVcvVEpiVzdqTTg1NDNmZFZl?=
 =?utf-8?B?ZW90UkM1NXhuWFVQcWNnUlFxRVRtaWNYbnVZVEFOeGFlb0YzMWhuWkN0bVBQ?=
 =?utf-8?B?TWRTcERPZ25SS2JmSjlFQWxyOXk2bW1BZ3p1QzdQT0pFTGt5MU03TmIrS3By?=
 =?utf-8?B?T0ZvMVY5ZmEwZFlHd2FZdjB2WktNNVBoSTVmMWtsMlRXbUZZOENSZ01BTG92?=
 =?utf-8?B?aVpaaWw0YXZEWTNua2l1V3ZNdnZpenVqUVNpc0dXbWx2VW5xdXBaV3M4dVha?=
 =?utf-8?B?MVkza3BJd1EyNFlvMUJLQXJlNjZhOFEzT1FtVS9TNElabWxQZ3MwQ2gzUlZ5?=
 =?utf-8?B?VTM1YmVtMlVENlpkL2szQ2pWWXlGeU9zVkRUQjBBWlN4L2hyZmFhN3FtWDlI?=
 =?utf-8?B?NFBmMERnbVF6OFR2ZTd4R2N0ZUZ0MWRVUzdmU3ZONUplVHh1OHNsd0I1SnRQ?=
 =?utf-8?B?UVczdjBpdHM0TmVZdVUxMEkrc0ZMM0lkTmxid3Q1Yi9NVVB4MXFiQ3RUY2dO?=
 =?utf-8?B?MmNYUFZKSGFuUkpJMXdqRkdUWThLWVFwbTVyTTRxU0tKTjR4aGNSSDdqdU5S?=
 =?utf-8?B?QWIvdXVLQ3B2a3huV044Y3NSeG9MUWZ0a1k3cDlBVGNEL2VaaG0vUllNK0NW?=
 =?utf-8?B?MWZyNUM3ZGRRUzBtM0xNL1dMQmRLSGtuSDlUZ1dFM2g4R1VtZVJNR0tnQ0hP?=
 =?utf-8?B?UE1sQ3VYTm5xVlBxVm9CQ05Fb000YW1PYzFPOFhVMldWR2JpdzJ1aVhxQjdk?=
 =?utf-8?B?UnNIdGpvcmxGLzJYKzBZTW5sYzFKMy9kcDFnVk02UmNFQXJwMTViWXIraCta?=
 =?utf-8?B?U2xaRWxoSDRLSDU3QUFqWkZCZlQ2Wms3NmNHeEloRTkwazhvNFpRN2FkNGZy?=
 =?utf-8?B?L1BobjQvNW9NWU1KeUxpS0FUV1RHYk5JRTNQQVF4SlZpbldtdHFXNnFOQysy?=
 =?utf-8?B?TG5LeGxxbTdaWG9Ub01Pd0ZNTnVuRXNTMnVLN01relBTNEIyRGdXSkVVRER4?=
 =?utf-8?B?cWJTK25VM21FYTVha2d4NzZDOTBOTVFjNUZJQTg5SWF5WXJLbnVoM20rbDEy?=
 =?utf-8?B?MG8zT1FGSUhWMEQvcjYzS2N6algzVXVLdzFoeFFjT3lmNmkrU3pUWWpsMXE2?=
 =?utf-8?B?dXdHMUxhSFlVdSsrbWZ1TExoWVlGSVdjUkZzbzJ1YkNmNTVQTiszTmZTbEpY?=
 =?utf-8?B?ZjM1bVk0VlVtaHFNUWErbzVqeC9RNkZWZlNqdmpOekxDMW8zdGlNcnRLdjFP?=
 =?utf-8?B?K0hYN1NkMjZaZGcxbitRMjcxRTAyTUZtU2ZJWHBZMGtvQnB0YlFKWmJra205?=
 =?utf-8?B?VFVtdjZFMGtjNW1kSTdUTUpIdEhwKzJMc0JHMWQyQ29zQmpmdExzZ3lnaXpj?=
 =?utf-8?B?STNXNjFObzJLNnllU1hNZnhrS2t3aDhPVnlWVmdWdmIrQWhEaU5yc016ZDA0?=
 =?utf-8?B?OUwwbXNhV25UREo0ZEp4UDZjVkxsazhVTEVRM3Bsb2NmNFllMGJQM0FPeTRF?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbbb84e-11cd-4eec-cd73-08dd2e68f8c6
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 15:44:14.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvdNUqyWQzmFXrsl2Otx9nxD540+ydSPR1OkeSQD9EuI3TLurRX5JJH+2T6hwcYXUqNTUOW9J/p/h+gxJj4QXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8856

On 2025-01-05 01:48, Stafford Horne wrote: 
> Hello,
> 
> I have all of the tests passing now under OpenRISC.  I would like to clean up
> the commit messages and send the changes for review.  I incorporated your
> HAVE_REGS_AND_STACK_ACCESS_API patch with my changes put it on my branch here:
> 
>  https://github.com/stffrdhrn/linux/commits/or1k-rseq/
> 
> Your commit does not have a Signed-off-by.  I am happy with the change, could you
> fixup the commit message and submit it as a patch?  Or is OK if I do that and
> add your Signed-off-by?
> 
> -Stafford

Hi,

You can add my Signed-off-by and submit at your convenience.

Thanks!

Michael
