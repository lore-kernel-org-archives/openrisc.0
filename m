Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021098.outbound.protection.outlook.com [40.107.192.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41119A288
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188014; cv=fail; b=Y5WxnY0TYJjEaOnZ+WSiw5AvPQi/XCqXzgRIoTFGpWA1eB7xXqFPw2V+sOMPxMdMDFqow5mPoa86jenb1e5lcDlB+oeqjylF90SpGyCWEmSN18zsis68Rfhipu31hn3/Ei56U0y9MwkLTg2kqFKg02QkvJl+Y3YQGPr19SRAfpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188014; c=relaxed/simple;
	bh=dcUlreWn+MSxha+adffZjZ7CAF56XM98pZtwuEQUvv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sXKbB5VQMXQOUECn7s4PHxeQ+2x4EUFUoF78Ze85AOfzhBug7Qpb7bOKZ4N7dwACGTTnNjKFQBruVYjyJsC+JH8QLhwImW7Clcq3jH/dhfd4xmySCwmUK7IyX6Q5BiTTjH/znQQjGUbtujUyz3Je22olYBLhJrnumb8kOBml1xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PQ1A0waU; arc=fail smtp.client-ip=40.107.192.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PQ1A0waU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqGEcblHZqSd/VumFSmC+O1ryEsGe8AoBiEypIp1LJmMW8c2m2clSy9r5IWoLjVWuT74YuUCxJZZU1ZelkHA8Y7wyIzohtE3SC1BxWz5ZLIq7PPpf7T5PJUasSXrwf4/36swcHSx3mIFSIyY39mC4cvy4mp2oikqKehpd5EMqwBeEugnOg0Wparf4kpYOdP4yhFAH8OmbuCIEXV5Gf6QsITyvCzsHyyHw25s1IsYNFqhcjHe9L6Px3rJFxCfXaTbyk1PFBwXgHWVBoW8mhqHHfQsfsULhpSMTeDGwS0CwIeEM3uwjWqw9vrTGC6kaAL5J8AVP4CXQB/x3X1n85bHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zC7x36mfTo4xIx3JPwwIonzkhFVwm1qxR3f0FCqsY4=;
 b=h5bK348/2hG+LIzanMr92i04gv++oFKBcgzGTPFWFIrg4Gw4kRhnB99ZjT7rafxt1F7yaVXk5UeIwNfSufUAuTVvupZnY8D6oGpHbkGFJB3GnUG7GMyNk3vmBhsegBa2BOxBYKP5IndACCNjQtdJtTGqN5pq1JBoYSmUDP7ORUX5Cj14atfJUIfJATJZIkcylao1MUMZbEkgV0svS1f7Bi1edT+JZLa7rQ/pS/a1WwUoY3uYRFvoV1EtILg3k4TnOld5aeGixJqSmmLtKXkznzMaUPDIHbjTyigxqM+zOKSHeIhRFKTWHcJhDPhiD0ofRObPqP27eL2/AyoZR+sWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zC7x36mfTo4xIx3JPwwIonzkhFVwm1qxR3f0FCqsY4=;
 b=PQ1A0waUhC8teQHu6u1gl47he1yMeQ5y5KJJETpUWn6iFD6ln39Qy6gjdrxKigl9FF+7+qP8SlcrWZMR1RWJ4wRA+zsT5TPCD55W4rcldwNEwftA+xjdQEI77jgvKunOvbHrS0qqwwIKD0NJqS8RpKNolwOSS2tuFptGdukVFf7exEi22YQhKhkeTsxYYdDegkfljHyxh3yNK8RdhGFhaGeNEdv2/3VcWJGOfqevwyv0mwz9D/Q7HPxqNLR/xw2Cwp9+8GHed8eId59evSjh7Npie29woLs78eMUZSuEa6wBSG9N0pUPgdE180pHjfAG52sNdar4oUPnRV2ceZIOqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB11112.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:145::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 18:26:49 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.8314.018; Mon, 6 Jan 2025
 18:26:49 +0000
Message-ID: <9dfd2255-12fe-48ba-a6cd-43956a08e685@efficios.com>
Date: Mon, 6 Jan 2025 13:26:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 GLIBC patches <libc-alpha@sourceware.org>
References: <20241101192339.123141-5-mjeanson@efficios.com>
 <ZzJ-T-5VFZ8gZEf7@antec> <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec> <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com> <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com> <Z11l_-7RV07JRwCo@antec>
 <Z2sXcENuw--JWlx6@antec>
Content-Language: en-CA
From: Michael Jeanson <mjeanson@efficios.com>
In-Reply-To: <Z2sXcENuw--JWlx6@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB11112:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a2fc10-f739-43fd-90ec-08dd2e7faf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDczSjlQVW11MVNqbGRLQjFZVkk2MmFmdEpjQnB6NXBHbjBlUW1zNlVrY0Rp?=
 =?utf-8?B?UGgwaGhXTStxOEk4TndtT04veEFZWGk2OU9VM3o2dnhxUGhWdG1tUFozT29P?=
 =?utf-8?B?b21BRTIvcnNDZVdnV1B2THlBdFU1cU1LcS8wMVo0SEFESHg2QUlIbjExQVRG?=
 =?utf-8?B?c0ZQUGxzMVZGODNESit0WFBhdzRsOEg1UTVEVi81NTFSSjNSS2lsNHlTdWZB?=
 =?utf-8?B?VnpESmsxa1RRaERoZW1Tdk1QNEFNV0k5RndhWXpZZFFqYWxmZ21TbDVuL0Ux?=
 =?utf-8?B?SkorRExkVE5zMHNudm5WZUltcXhpZm5ta3hYUVBrVkNDa1VUWXpkdlFadTdC?=
 =?utf-8?B?dUtJeHJsQkp6dGs0Y1dlNWZPUmRsNVFjRUdJcFZTSWx5Q0UxMi9YRmZyZmVu?=
 =?utf-8?B?dDRmZEt1YnRUYWVPUGxmZm1vNXdFZEttajBuaFNtb29tU3BlRURHWUNEVFFp?=
 =?utf-8?B?OXY0ZlNQODBDaXpoVWw3aGVpOE9VNW1NalZhZHNYVndWNVlYN2dqNk16WVNE?=
 =?utf-8?B?TzNWTFgrNWFnay94T1N3RWNsWTBVZFQ5R2d0NFVyczZwUzBWbGdPK2F6bFA2?=
 =?utf-8?B?ODZ2SzE5MkF6NzNsSXRDQUZOK2diZWczNjBmcGZIek5aOEEwa0dJbVNkeTR4?=
 =?utf-8?B?WmlydmxTZVl2SHlKSUVOb3UyejZJa0JPREZQQXIxcUhBMWFPb0ZGaTA1VWk3?=
 =?utf-8?B?U3I2SXRHVjNkMFBzNGRBTGt1ZWVHM2d4K01ONnVHOWF3aS95TTZpUXJGb3dm?=
 =?utf-8?B?ZUJJTEQ2QWlqeU1IMlJPQndwMDViSGxqTVlTeGdlenVQdkZmaVh3RWtvZFV0?=
 =?utf-8?B?MHIxMzE4VnV1WDdwczNwWDMvdWZ2NWt2cU1KWHVpdU1DdFc4T3dZMU9uUDNJ?=
 =?utf-8?B?RiszeUNYQUVCTXZzZ2dVZUVndUdCTkk1dTB0QVZqZGYvZVo4bnlTdWpPMFBX?=
 =?utf-8?B?Y0JWZkQwYVdwanU3OGFwVTZ1cUNiVjdpei9PemNVdFYyK0NFUXJCYUdxRVc3?=
 =?utf-8?B?MUpGTnhFZGNTaDV6SCtqa1Bha2RuMTc4cHh6b0FMZEJxZ2pFTSs1ZThNQ1ZE?=
 =?utf-8?B?SDM1d1QzZ25wdmNoemdCZ2hWVTdESmhudjJNY0k1NEdaRC9XbUN2bWJsRGdw?=
 =?utf-8?B?L3g3ZVZrODkxQUNKbFRwdDRIUzRoaWhxSTBrWG53QVYxM2xSR3lwVWVWZCt6?=
 =?utf-8?B?ZDlGWTh1VjFXaFpIdVlZSnNrbDl6ZFAxY0Z4RDJwMkpXbEtoSWxPV1JES3dS?=
 =?utf-8?B?MXR6UGZDSEtwbXFhM3FaQnRPTjZ4V3cyUHlWMVpkT0ZaZzZSY0JOYkN6d2ZC?=
 =?utf-8?B?bzRUR2tXdnFvQkhlNXg4ZVh3aWZXMURoUUwrV0lrUkF3aHhuTkRnUHlRZXFK?=
 =?utf-8?B?aTA4V0pQQkFGUytvdllRbklaTXFLdWQ5U2RKbWtaK0pxWHR0V1BmR0Vja3Jk?=
 =?utf-8?B?Q2N1MTBwQS9pV3IweHBLMzVJY2hFbmF5SXBTQXgveS9kWXpsbVpRcVFERE1Z?=
 =?utf-8?B?eERnbVI2WW9RNUd5Zzd1ejVNREVZN3IrVTh4Yzd0dy9udVhhYVRPYWJZT0dD?=
 =?utf-8?B?VjcxV1I5aDV4by9KNDI1QkUvY25NWk9ZQ2pGdFc4R1lPQU9jMTRDcjNoK1l6?=
 =?utf-8?B?VXI3d0hSaG9BVHYrK3JrR1Y0NzhkSmpjT3dzOVRaOTQ5K08vQ2FZMCs1elZB?=
 =?utf-8?B?MkE0SWc0aitwZ0NQZEdkMFM2L1R1Q2FDNXBzc2xrUXdKOGJ1ZkQzcVorMTF5?=
 =?utf-8?B?bnl0QnpZcjBzc2FsTjY0VGhRZ1BiajVUVzNoVXJPamcyUU10YmRNbjIwaWVG?=
 =?utf-8?B?aVEyeHV3N2p0ZC9tY3hhNWczaEhhQ0djN1EwdHo2b09hSDVEVlVOWEtxbmxr?=
 =?utf-8?Q?N2t6v6OLDFa6h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTc2SW9hMi9DT1lEaVJoWGl5ZUhUWVdnN3dtUit1RzFmOU43c3ZkcnBOUktm?=
 =?utf-8?B?c0Rqek1Zc2d1WnZ2ZEVkWU1VUmYzM1BQbmtSazNBcE1jNy81WmNiajVTWml6?=
 =?utf-8?B?NWhXMlVWenF6bEh6ZEtVdmMzWGd1MHV0d004WHR0MjEwekpheGlNU1V3TFZx?=
 =?utf-8?B?c3FCMDFDVXdqRUxrWHNnRU9LeURmNVVaQzUrNExNWFJJTVU1QU9zQ2ZXdksr?=
 =?utf-8?B?ZGhTSTFwNm9nOVRwK2tXRitrbi9Xcm1hZ0N1TWhualNCa2pmNjhZZ0xzb1BM?=
 =?utf-8?B?VzlBemFQVEZ3dHFwUzlXVGlUV2F5MDBxVzcwcXlXRm04bHB5dFo0MHRPRnJx?=
 =?utf-8?B?ektiUUMvVkdtaHdxTGkvZmRjZW9jOFlXTmRsaStnRWhSdkwxT0hjOUtIK2Y0?=
 =?utf-8?B?Kytqek5ydDZXU3dXQ1RnQVZrSmdubnZBb3V0eW1RZ2RPUWlDUzZjbUthcTFZ?=
 =?utf-8?B?S0hyZ1NiaTlRS2NUY1A3My9GaVlmc240K2kyeVRqSXZjNVdWbjhsTlNyVjU4?=
 =?utf-8?B?eFU4ZkQ2R21VK0FxWVRJQmNjOFg3RDdqcFJ6LzFNWFRma3ZlT29USnY5OTJw?=
 =?utf-8?B?YW90azg1SEpCTlZsb2FJVFJSMVJ4d0ZJV2twWXptSDdXOFVVRTA3eHFOaXJo?=
 =?utf-8?B?ZzJrYUN6U3dPUlZjR3pvNVRhWDBpd3hlT0RFVmFhSGsrQXpXcEF3RDRIZUVN?=
 =?utf-8?B?Nk95eE9LeUNZdnAvM0phbUpzNG4xdGQzcDFFQmViTXpqQmdVMlpwc2RibzBB?=
 =?utf-8?B?MGhJenJ2NjhUdWtOSnl5LzU0R29TV0NZTWdsZmNOaXpoQzhsQUxHR0luN0VR?=
 =?utf-8?B?Q0xqUHVzVU0venhhTXczejVBdXNCakV3MkhjcmtrOWVQNFd1Qkk3MjMrZ0N5?=
 =?utf-8?B?d3lMVFZpMUZNS05oM1ZtKzNtSkVQZVVNblBweVNMcHNndkN5R0ova1FqdmhB?=
 =?utf-8?B?dnZ0VWpackwrdG5ZaXBGUEs1dW1HTkN5NnhEbTBlRExzek8xZUMraldCbGww?=
 =?utf-8?B?cTgzQkhBQzhSMUFPQWNkU0tXMDdWaGNURTFmRUN2RzhtUnU0Ym9pVWwrT0JZ?=
 =?utf-8?B?MTZQUzgvNkN1NjZEQk9PTU80UGs3TmIxTWI0Z1VtR08vTUljdmFMV3VKRkpG?=
 =?utf-8?B?cUF2aHI1bUZBZytNWGY4OUhKamFONnpzclRoMG83ZTNna0tlL3o4S2ZRaU80?=
 =?utf-8?B?bWQwYXEwRG44dkcyaTZseVIzQnpoUDE1MGM2ZlRsMmR2R2tpU0dKOTNSTEh4?=
 =?utf-8?B?YUgwbEtNd0IrZGZCUkVteGpXMDlRazNvM0RzVXVMcFRMb2h0VVlnRXpZM3hq?=
 =?utf-8?B?YmFXQVAyNkM0cE5ucjMweUgweENFU0JveTRIQklOSkRicFQrbkZTZEo0MHdR?=
 =?utf-8?B?NkJRbFhLeERVcEZ2dnBlakdWa21PcTFBZTFpZ21OU3I4dFNMZDRNZEtYblNS?=
 =?utf-8?B?TjI0YWYxY1l2YzdLNUQ4RTJ5MDQ4M0NLRFhRTGNQU016R1hJektKeFFXMUl1?=
 =?utf-8?B?cm5nb1B0bWg3KzlUdE51MDRaY0xkTGpqaytsMzRpSEYzUTBqUm95czZvOGRG?=
 =?utf-8?B?OFRYMXRzMEV3NzVQdWFzSUxYYmdvYzdKVHR6ZzhMN2daZ2d3K2Z1S3IwMkhY?=
 =?utf-8?B?WHQ0U0pLZ202MXlMRk9UN0liZDBIY3Y0dkJSUmpuK1ZCT0E0Wk96ajBUWmpE?=
 =?utf-8?B?OWJsK0RqbkVaVHJPVnBLbXR6V0xOa1d1K2tuQS9kRFh0c3JPM0tJUGJ3VmlI?=
 =?utf-8?B?ODlXQkJLeWRkUTJGYXpTRk5DVndFUFN6a0pKVjBWOW9hY1cvTWhFZ2huZXkw?=
 =?utf-8?B?UWxWZXE4bVhiczQ2c2tJVS9MVGduUmpsR3BCVnZVVGY3MFMvMnVZTGovMEoy?=
 =?utf-8?B?S2RSS1hXTWRaSWZ0azhEWVRsV0NnUnRJRDFQU3I1SWdHWGNHbUcwMm9nN3VT?=
 =?utf-8?B?bWsvckRtVzVWZkl4SlhzdWsxRldkOUM4T0lDVENPTlVyYnNtT24wUlBsYktQ?=
 =?utf-8?B?YzFxSVNYZTRyL05hVTh3SHk2eCtmWFExYTVnTWNGZmRUZ0dLNmRtd0RwRXdC?=
 =?utf-8?B?cEdJb3FCTkhHaUxZOFRkVmM1MFZPVGRvVUsrS0ZsWThjelF1NHJaeWVIN29q?=
 =?utf-8?B?SFhUeTdmcXVmcUM3Q2xrSW5ENlRYNnFvWWlOYkJ5WEFEZEREb2kycG9nUUQr?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a2fc10-f739-43fd-90ec-08dd2e7faf24
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 18:26:49.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M3ax75Zgc6TubVtbEQfNicinwIGM+Y2wX22A22FyxcYMlYiNcU3SE3hSMl5rjXudT1ZTYNPyylVb+3Qg6T8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11112

On 2024-12-24 15:20, Stafford Horne wrote: 
> I think this ended up being ok.
> 
> I have added the call to rseq_syscall and implemented self tests on my branch
> now.
> 
>  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
>  - commit 1fa73dd6c2d3 ("rseq/selftests: Add support for OpenRISC")
> 
> I haven't got the tests to complete fully yet though.  Do you have a recommended
> approach for building, testing and debugging them?  I am using my glibc
> toolchain, but I assume the original implementations didnt have glibc support
> available when they were testing.
> 
> My stack now:
> 
>   - QEMU virt
>   - Linux virt_defconfig (or1k-rseq branch)
>     - rseq selftests - built with gcc/glibc toolchain (or1k-rseq branch)
>   - rootfs - Buildroot with my glibc (or1k-rseq branch)
>     - gdb
>     - strace
> 
> In general I am using the latest git HEADs for qemu, gcc, binutils etc.
> 
> Once, everything is working on QEMU I will test again on the FPGA hardware.
> 
> Currently tests are failing with SIGSEGV:
> 
>     TAP version 13
>     1..10
>     # timeout set to 0
>     # selftests: rseq: basic_test
>     # testing current cpu
>     ok 1 selftests: rseq: basic_test
>     # timeout set to 0
>     # selftests: rseq: basic_percpu_ops_test
>     # spinlock
>     # ./kselftest/runner.sh: line 37:   772 Segmentation fault      /usr/bin/timeout  --foreground "$kselftest_timeout" /usr/bin/timeout "$kselftest_timeout" $1
>     not ok 2 selftests: rseq: basic_percpu_ops_test # exit=139
> 
> In gdb it looks to be happening in in an mprotect syscall in glibc and at that
> point the stack seems to be corrupt already.  So its taking me a bit of time to
> untangle.
> 
> -Stafford

Hi,

Sorry for the late reply, I was away for the holidays. From your other message I
think you managed to get through this. Is there anything I can still help you
with?

Michael
