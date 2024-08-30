
import 'package:med_prep/common/constants.dart';

import '../models/result.dart';

main() {
  Map<String, Object> resultRes = {}; // Your map initialization here

  try {
    if (resultRes['data'] is Map<String, dynamic>) {
      Result.fromJson(resultRes['data'] as Map<String, dynamic>);
    } else {
      throw FormatException('Data is not in the expected format');
    }
  } catch (err) {
    printLog(err);
  }
}

var resultRes = {
  "data": {
    "exam": null,
    "attemptedQuestions": 0,
    "isCompleted": false,
    "free": true,
    "active": true,
    "user": "615fc7db8ece1100125d41d0",
    "questionAns": [
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a40011223468",
        "question": {
          "question":
              "TOzWo50ppjxlu9M9ewp6Zd8B9A0QA+AVKNzx/ojqBOxjsis6RyegA33HpQHYOjYjjOZPyGCVHgQCPnlx+pgjG7ZGp4Mz9alQbldYzVapTmIFW+/H/ndyJ4GoyxD6sQxPMto6yXclLS/F//ETIoWW57QteoVN6b183dvZxFSRYdq6SsnNiqKq81IwJuP4jt7yxX2L5+x+UcaLXJsQrykZ4MG8G3Ele78X3yOFd3tVt0jZBKxQuWb3D2/8qvwbqjaH4XtJXuXhsZ2wc0dikfhLo6euuS3zpN3Z6kq2ZdiPnON0nEDwwU3yt81SWH4USx/7EyIKgX8FxLrBi56OODK+lxVX6Smeu+UJhbhZL70qHXJEYx6dMKhN/UPFC1u9Y+0Knrj5ln9LbbFU0XYEm9QGi1Vzmumkzg+oWmFXKuszPE/KK3bmxPrxTLGRY4nyH9ariB2akTqzuGGFKcs/KroK48ylq2ex4w5WsMWk9/NqBxR42g1sAPSESdfvAe1tfJsfZf0mSqHbV/btV9pi7uAqIjeHOz2vp0ek3E8jW90DdUSRt7DjvhoDdXnLXYzo8KIPTZTD5Yo/E1rKPz/mi4Ux2KMuKeOHNWPqTUsPPPNkEKAN+Af9Qr+P+QNwpMVeBVyti37tpPSaZKUMp3TIl4Nl0n1MccaZFJeHjHlUt+63ug4=",
          "optionA": "Flexor tenosynovitis",
          "optionB": "Cheiroarthropathy",
          "optionC": "Amyotrophy",
          "optionD": "Ankylosing hyperostosis",
          "correctAnswer": "B",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><p>PRAYER SIGN</p>\n<ul class=\"ulClass\">\n<li class=\"liClass\">Focal lession (CHOICE A)</li>\n<li class=\"liClass\">Wasting of muscle Proximal leg muscle(CHOICE C)</li>\n<li class=\"liClass\">Diffuse idiopathic skeletal hyperostosis or Ankylosing hyperostosis or forestier disease - ossification at skeletal sites subjected to stressinvolve spine involvelment (tendinous/ ligaments attachment).</li>\n</ul>\n<p></p></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.544Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c664318e38d7b3c7548"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a40011223469",
        "question": {
          "question":
              "nInMuk8S498584A4/JJpF/4/cstAEgcQhiSckXLuELOJRMOYT9wudhnTFa5kwEgaNOpYGSK3/e8N45BS2UuIVNNK0+2NA4OIsrqgiNoZugMcVJ0Qi7o9FAXCqf3vRkLGhaA2GqT7r1EkFVIfrucclKebspjByaHLiK27B2/t1q0+tvBvnuf5sqyWySRBr2/cugN6XvVAEI6s28RY951V85RjS8KVaaMZGa5ypdkH7NZ5JSzq7n0/25dUF09R3ldGXwypL0sjmSsYEh61WTMshyVVsoTbfrbVJ6q/tdSDB+J96vvMpTAXqqPTjJuOKqR6KLqrDYIG0xLUGm46hjal78q6w0Vs/O2dhFbmDowE9bzLqkGOIZyXVPHmlqOxH86mgPgefiwiU+2OcYCHSaXTw/nQYm4i07CLEqaYHUF19Zz6I1bM1u2GneRZOgDSMy7ExGaeCWGUoPoVdoZSMxC5+SX6Lg93I07aAhLyUqbiPz5x5/9u6ylfihRsNGw1lWMxjovPRn62B3UKLAonuVSTf7egwnZojHnenNjyJM4LhyA4Fyh0wVV3jbOldvsZjXmaEfZ2+VCbS4syWpQ1WaXRWjTgCWJJZ4UFBBDUstK4HAua5Cf4h85Ga6GDARlyxhtxtvETpIBxXuugryd6gRQ0iAqh+YpZyRX6T0ecY1QFjMc=",
          "optionA": "E. coli",
          "optionB": "Shigella",
          "optionC": "Rota virus",
          "optionD": "Staphylococcus Aureus",
          "correctAnswer": "B",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><ul class=\"ulClass\">\n<li class=\"liClass\"><strong>REACTIVE ARTHRITIS</strong></li>\n<li class=\"liClass\">most commom features:- oligoarthritis,conjuctivitis,urethritis and mouth ulcers.</li>\n<li class=\"liClass\">usually follows dysentery or a sexually transmitted infection.</li>\n<li class=\"liClass\">HLA-B27 -positive in 50-80% patients.</li>\n<li class=\"liClass\"><strong>Reactive arthritis causing organism :-</strong></li>\n<li class=\"liClass\">Shigella,Salmonella,Yersinia,Campylobacter</li>\n<li class=\"liClass\">Ureaplasma urealyticum</li>\n<li class=\"liClass\">Chlamydia</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.546Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c684318e38d7b3c7564"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a4001122346a",
        "question": {
          "question":
              "H4JC5Xo+gq/dNrSxtUlJeY92W1HclHXKPur+p3KvleMdatUn2ZR+Y+rgNnwZ6Ffx0++XN7D4yLUkSX5IS3PLD/W1WqkiVo2rv/YflW6IZM+kD04nJKUwUU5MM79Gybb30LofaVy/WQ3qNO4+tQECs8YYITOlq72/cOzykV/VIDeBmGoc6xSOrAqhnDkzP6tI82oqau70IfQJxZkkqk4sbAwM8eCqu+chfrSuU3y0e0CXsEhN369USeqyJ2E2+iUoYeFkqBMRroeDUl5YfKWptQQzwOKlMe8bk83BdRZdFahjWXl8X5JLmvR6stSAt0QcNUzIG61z3Jl4RU2f2w96ITopNHHxpeBcoXKHGaEsGopazzh1MN980TmuslWFd4B3KUizsKbOMSABlVqnIb6bQ0I9mHKhwgXHYEkyHBYOW7eq3KitReTZyAW95Q/vxuKSrt+wN2Hu+CmL5jPN9+DNAdT90FBmoq9bvJ5nKsqUhPKLU0auGppS4WA8vqZP8xygJEoaqMO59kuR4SyBeFYTSob+l0a+X2R8eiCxmDRMIbuf41Of0Xr27UzYMgv0igKO9cA4wLnOhs8YlLwa9UiNIj3LmcQgqZfwsB9Bmthy7QZ+XYrRZE++MkZZCWNoxmtpQgEAJdpkoJ2G/1YhC2TI3eNWoMujk8fpDteEklq812s=",
          "optionA": "Epsilon amino Caproic Acid",
          "optionB": "Tranexamic Acid",
          "optionC": "DDAVP",
          "optionD": "prothrombin complex’s Concentrates",
          "correctAnswer": "A",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><ul class=\"ulClass\">\n<li class=\"liClass\">Reteplase -Toxicity Signs:Mid dilated pupil</li>\n<li class=\"liClass\">Stop fibronyltics</li>\n<li class=\"liClass\">FFP used</li>\n<li class=\"liClass\">FFP not in option so epsilon amino caproic acid</li>\n<li class=\"liClass\">Vitamin K antagonist -Warfarin toxicity (CHOICE D)</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.548Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c6a4318e38d7b3c758a"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a4001122346b",
        "question": {
          "question":
              "q8yP2ukzEGIx9RNpwVluEgtZmP65sOJOB5qMe57G9QN/kU5SFBLSvPhh3sNLqQNt6UOg84HzueK4Co26bsjHNDofXWAbHW6S4puikTrLUuo/BN2dSM57IqQx5Peb1eDWCYI3LhckrFWoC92r2uliH++rMDoFVu43KFFQiUKTN5wHFUNt7eb45BR2nDDtofT7DQdjfIDSUYPFhoQeUCnQqaeKdHwxtpO7piKpf/X1AeLEJGt+PD+alwVef1OvEVUEnNRu0erTSRNi6Knka5WNXfmGwISisK6/iAAwjMAfFoWuKXZxXnxUmfmPlfiudEAUeu5JQR/ruy7oke2qfFC4EcqzjX0q/z5UklgQOe/9s3L1dpDVW1xOjCw7jW/fjmevAo89+L/IedNSEyJ23B9buAZ+YRDEvUNHtgjxtvzkJ9xLqBJol4y3ySvdYT26omVw2HUtKHILsYFKWep6RkYy5pVNvjQC8NXf3b6ZXtHy89A3V2Cge63u7RA+mIZIYFyvE2CXN91OTGAuDgEA9rg/6kzNoJnoGY+ons938bPZfyv2jb5JUBR2joCJqgce9jtewLGyrp/Qzcnob6UJiqXCs09Byn7oIlL00K8wARJVbWVny/UIX1S4aF2wb7roqopf+4T6bDxIoNd9s/xrTiip2ou4dQ60dLlPBwLMoSfkcww=",
          "optionA": "Parkinson’s",
          "optionB": "Lewy body dementia",
          "optionC": "Multiple system atrophy",
          "optionD": "Alzheimer diseases",
          "correctAnswer": "D",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><ul class=\"ulClass\">\n<li class=\"liClass\"><strong>Alpha synucleinopathy:-</strong></li>\n<li class=\"liClass\">parkinson disease</li>\n<li class=\"liClass\">lewy body dementia</li>\n<li class=\"liClass\">multiple system atrophy (atypical parkinsonism)</li>\n<li class=\"liClass\"></li>\n<li class=\"liClass\"><strong>Taupathy:-</strong></li>\n<li class=\"liClass\">Alzheimer disease</li>\n<li class=\"liClass\">PSP (progressive supranuclear gaze palsy)</li>\n<li class=\"liClass\">FTD(frontotemporal degeneration)</li>\n<li class=\"liClass\">CBD(corticobasal degeneration) aka Alien hand syndrome</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.551Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c6d4318e38d7b3c75bc"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a4001122346c",
        "question": {
          "question":
              "YWq+HQIlIn7IHd6utsSVSNfdFIshjHepOx6MIwRJiXYfuIb8ysaVPbXVOP7MMgCWh7tF5oMd+b6NUtG+osEi7nHuG6a0ztTYAkiRukGGP1tqq/91xHE5OEAl+6Y42yP8ygttzCwQ4ObUz+j0HIxKmeKDK5G0/LEc9Q9Sttrwg9cRYhOyoMADeK0CryQC2NSi4jmkA18Y17MSxysPF7i1rZH+YcsIosHck0/nQuctNj3AQHZojx+GOHUuacAYQaRDKNvi2Je4h0DkoO2ncTi3poLwAuyC1a2KBLArdcBDYKFYhm3+YEbnMj7fJKb8PtR/1nA9nPdQ7gkS3W0ZJsu/cIP6S35jkkz6PNxFX3XRJsxKvMDYHqXAGOxdNLV+tUiw9xtv43ugzzsOHJPoBukwtowFnIa3uXT6cz3pUKe4TqsCAgQNRQh1ny4+Wclrsgd4KV/4ZKy/CFHhSQpgaa0OP3Gd+SLJ7aQe0ajq2gg8FFhgkLNUovWXtM9KlPVP3Jv27Q+4afd2aowFyyIF0HNEIDfe+bwWggfqzGsea4SpxFS9tacIXHScaKV1ErmdQol6152/9/y0KvhE59xGtxE8pXZUvUSIMLq3Lr5iZiRwoBIMaa6V0q58+GaczuEJJCtqMs6HQspoCuQRCFbuiraBl84bkZYhCYm1mSXzuYGSBUU=",
          "optionA": "Tuberculoma",
          "optionB": "Neurocysticercosis",
          "optionC": "Toxoplasmosis",
          "optionD": "Cryptococcomas",
          "correctAnswer": "B",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><ul class=\"ulClass\">\n<li class=\"liClass\">Focal seizures due to ICSOL.</li>\n<li class=\"liClass\">This is MRI shows multiple lesions all over parenchyma ,TARGET SIGNS visible.</li>\n<li class=\"liClass\">MRS tells chemical metabolism of lesion</li>\n<li class=\"liClass\"><strong>Cysticercus granuloma</strong>:- round,cystic,20 mm or less with ring enhancement or visible scolex,cerebral edema not enough to produce midline shift or focal neurological deficit. <strong>TARGET LESIONS- lesions with central nidus of calcification or a dot enhancement.   MRS </strong>- AMINO ACID PEAK</li>\n</ul>\n<ul class=\"ulClass\">\n<li class=\"liClass\"><strong>TUBERCULOMA</strong> :- Single asymmetric lesion,solid,greater than 20 mm, associated with severe perifocal edema and focal neurological deficit. menigitis x 2weeks.  <strong>MRS-</strong> *lipid++peak , *choline/creatinine ratio ,</li>\n<li class=\"liClass\"><strong>Toxoplasmosis</strong> does not cause scattered lesions ,in this basal ganglia lesions and eccentric dot sign h/o AIDS positive having opportunistic cns infection , CD4 count &lt;100</li>\n<li class=\"liClass\"><strong>Cyptococcomas</strong>- SOAP BUBBLE APPEARANCE on MRI, AIDS positive person, lumbar puncture- CSF ELISA for Cryptococcal antigen.</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.564Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c794318e38d7b3c7684"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a4001122346d",
        "question": {
          "question":
              "UQ8PmDFppG+MmhcMWhjZniFqSUBdstxr+nut0vfRNpLU9qPA4nb17v7REGcB4dadtt8VQZkm+a7U4+5bxOXame4CKEMpchTSQOSBDHyk2GSJzBvj+5ZX7EyGCcEhzsJqEu83bEUqO3/NTSxtfZOfynpI+HL6tjsTSudVQT+b0kjCqtPoKvOe51dpeqkwCutKgM3sqdozoHwjGY81vqZYRIyYP2A1YNkbuv2jYEtgPcGfFkDp5mvJhqelGF6ajBb8mNvJ+bAoJE9OSP6kKd8b98NsCMCEBorubmEKLwt7xn5F9pJceasi6ip1yG2VyQbyCJI/OmWSz5itJ1c5cEy75VeCDyBXBJ2uuDIr72+3XX1JSgSnfKS0/9lSQJLe32Q0+3iRAvBV9hS+tC4Y6+oD6q5NslvrvWw6XG4OsCgS2zJKIK289nOwu2p7CDCK/KSvBF+x+Mj6HtGyMFdAoTFXSJP34rZlloFx6Xp5ycDkBFbx0Z/eY5yE/vfT8B7rPWbkQ8588l5knSHSpktnnU3v/CHqPsQfeBjnfa8atg4ERXQA/x+8QUdbN6iDEKTDH6f98wY6bZPHucRvhbQCMkMrnz2jik2wkM5kpZWpGekcFSiDcsTJTFm2IzPiffhcYstsLgNqo0JSrmN3l9GFGk+wUhMqDMJYgIxvwvlRLZ1F1iI=",
          "optionA": "Superior cerebellar artery",
          "optionB": "Anterior inferior cerebellar artery",
          "optionC": "Posterior inferior cerebellar artery",
          "optionD": "Basilar artery",
          "correctAnswer": "A",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><ul class=\"ulClass\">\n<li class=\"liClass\"><strong>IN THIS CASE:-</strong></li>\n<li class=\"liClass\"><strong>vomiting</strong>-Increased ICP , <strong>dysarthria,muscle weakness</strong>-?CVA. Right sided limb weakness- lesion probably left sided.</li>\n<li class=\"liClass\"><strong>Right side-Horner syndrome, limb ataxia</strong> (cerebellar involvement)</li>\n<li class=\"liClass\"><strong>Left side-sensory loss</strong></li>\n<li class=\"liClass\">Crossed lesion + brain stem stroke-LIKELY</li>\n<li class=\"liClass\">Cortical stroke-UNLIKELY -because no aphasia,apraxia,hemi neglect given in this question.</li>\n<li class=\"liClass\">Internal capsule lesion-UNLIKELY -because no C/L hemiplegia, hemi anaesthesia given .</li>\n<li class=\"liClass\">Dysarthria is a featue of cerebellar lesion also.</li>\n<li class=\"liClass\">No cranial nerve involvement.</li>\n<li class=\"liClass\"><strong>Superior cerebellar artery-</strong>Involvement of <strong>1. vestibular nucleus</strong>,(vertigo dizziness)<strong>2.superior cerebellar peduncle (SCP)</strong> (limb ataxia,hypotonia)<strong>3.spinothallamic pathway</strong> (C/L pain,temperature loss),<strong>4.medial lemniscus</strong> (C/L proprioception)</li>\n<li class=\"liClass\"><strong>Anterior inferior cerebellar artery- </strong>CN 7/8 involvement</li>\n<li class=\"liClass\"><strong>Posterior inferior cerebellar artery</strong> -CN involvement 5/7/8/9/10/11, Lateral medullary syndrome-crossed hemianaesthesia</li>\n<li class=\"liClass\"><strong>Basilar artery-</strong><span>Locked in syndrome</span><strong>-</strong>can not talk,walk. MILLARD GUBLER -CN 6/7 lower part of pons involvement</li>\n<li class=\"liClass\"><strong>BRAINSTEM STROKE+HORNER SYNDROME:- </strong>it can be either SCA or PICA involvement. If CN involvement present:-PICA.</li>\n<li class=\"liClass\">So correct answer is SUPERIOR CEREBELLAR ARTERY</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.535Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c614318e38d7b3c74ea"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a4001122346e",
        "question": {
          "question":
              "guyZdoc2mYsYu1RjkEed8aJ/cVo509Nc2ncSwHUu7mVH+sUEVToXl8w99A7vehFEkJcz5d6T0Sr92oq88vN1RZsluC3trivN/YDQ0yn363I10VmgAjszvYbnrEKKrIq4GHnb00cvqRPvoPwOpMuS+digoKArhnnsjYeddNppHs6ZFWV6hQMS+gKYHab9lZFEyVQC0h965/Tb4U5S1DReNs9HfeAHTOQUPvMoicMd1ROVpLxmHfs0k6AR0x/UuF/kWgJ6DzmbAgYQk8+DJnkZ/jubUi9Kxtd89FSYFUYBRCK8L3rnWFm3NoKHyvd8rqYcopwfoFfJ9cw3kp8Fwc1IzM811M/HjGJ5sKB3Hlh8Vf/XgKrjybhvu/Be99MVu5o4OLuuqD4GAxIGyrHLnZv6mRBgT2UmlIHo8bzphW+HUHphuaXoWwCxzqQojmK0emffAE3YHugIdiDlW4CDrDqRW1gTafGPBtDBpYiNIwMmNrgbow5P9kJDhpOCZ7/ueIA2ZAN6BtAu9BVMu58JfiBMyLtxKaaPRdHjaympHRS4lDB0hsGKcqmN1dEZ4ADenHr8RI7PYxTiseS79RJM3hKxK0WNTAWy/YNtLqFkprJYLd7c8DWEVxGcV4i2hWaQ0f3IaoTjhzt3GQdcaXicm8kUOOO8R6lTrtArDVQCSmG/cIQ=",
          "optionA": "Nephrologist opinion for dialysis",
          "optionB": "Lenalidomide + dexamethasone",
          "optionC":
              "Dexamethasone + IV fluids + diuretics",
          "optionD":
              "Dexamethasone + IV fluids + Zoledronate",
          "correctAnswer": "A",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><p><strong>MULTIPLE MYELOMA(CRAB)</strong></p>\n<ul class=\"ulClass\">\n<li class=\"liClass\">Hypercalcemia</li>\n<li class=\"liClass\">Renal failure</li>\n<li class=\"liClass\">Anemia</li>\n<li class=\"liClass\">Bony lytic lession / Bleeding</li>\n</ul>\n<p><strong>Dialysis(peritoneal or hemodialysis) useful in reversing life threatening severe hypercalcemia difficult to manage medically.</strong></p>\n<p>Calcium-12-13 mg %- Treatment-1. IVF +Lasix</p>\n<p>                      2. Bisphosphonates</p>\n<p>                       3.Calcitonin nasal spray</p>\n<p>                       4 .Steroids(sarcoidosis , MM)This intervention work when KFT normal.</p>\n<p></p>\n<p>                      </p></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.538Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c644318e38d7b3c7518"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a4001122346f",
        "question": {
          "question":
              "oUz/LJwWVTXgSEWWY5fePdfwjS1G0BRzoinaETQmzuN+Srli5RaWcklXt8Q7nw05j/5ugjWkcZPQziDjghneP/ibYJfM0PVdhTfJ/Gy1RYAZUlAA301KwljM+A+7acRDoagdTgaldJ00S3cbfiump7dQXNSwZ8i5+gtbW1Ot6XUNn42Z4Vn8aGNZ7Xljp2mwhl+Gr23A5Qmbg5/JLrVWWb7N88fnsB+mXO26GqgKkOjGtqp5wSadikcah0802fRXn+9QMINNaN7egHLAQmoR37ZaisOfp7i6u6dZa0r70QNrb519zZF33aKZIVX43vIAOOkupTRIPb91b0NqM2fgP0AmR2QVuhqDn0TrQlags+1kh41X3uRPDel6PYFWAO4wuowob3u5wnHmpZCPHARJfIGrGBoEUGVb7j06Hpsa16p5MyYSWEo042byTTZ4GQCqFNKw0QT2cMwscaANaBYbPyx1KFgfEmr8sJUdP2cGUlEj2v7n86nBkMMm5jyecnMFyO3yG/JMmxI0njIKI0D1P/ofeUFcc/6xmX2lktGhU/6/lPAEo60EGi2nEI9bbXS/bhS1HwtJ95qnNhgWJ2cuvvkB3nU6MccHt9Fy5mVMIJ0YIbjwcs1pb1j5Lgza4ogEpsorbscc0Rnz67puatAHGM/XRYwK+LK+U7a+92ELoK0=",
          "optionA": "Thiamine",
          "optionB": "Riboflavin",
          "optionC": "Pyridoxine",
          "optionD": "Pantothenic Acid",
          "correctAnswer": "C",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><ul class=\"ulClass\">\n<li class=\"liClass\">NEUROTRANSMITTER -Glutamate and GABA</li>\n<li class=\"liClass\">GABA is formed from glutamate need B6 for this reaction.</li>\n<li class=\"liClass\">Glutamate accumulate causing seizures</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.541Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c654318e38d7b3c7530"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a40011223470",
        "question": {
          "question": "false",
          "optionA":
              "Give immunoglobulin followed by Hepatitis B vaccine single dose",
          "optionB":
              "Give immunoglobulin but vaccination not required",
          "optionC":
              "Given immunoglobulin followed by full course of Hepatitis B vaccination",
          "optionD": "Nothing to be done",
          "correctAnswer": "D",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><p><strong>Accidental needle prick injury in HCW:</strong></p>\n<ul class=\"ulClass\">\n<li class=\"liClass\"><strong>Unvaccinated HCW</strong>:- Give HBIg i.m ,then Hep.B vaccine X 3</li>\n<li class=\"liClass\"><strong>Vaccinated HCW</strong> :- <strong><span>Anti Hbs</span> titre</strong> : If <strong>&lt; 10</strong> mIU/ml = HBIg + Hep.B vaccine x 1 , <strong>&gt;10</strong> mIU/ml = no intervention required</li>\n</ul></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.547Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c694318e38d7b3c757c"
        }
      },
      {
        "selectedAnswer": "",
        "_id": "61bb71a17c63a40011223471",
        "question": {
          "question":
              "lhuqhlGL7wHbG4cnXfQSSIPN1N4Z0IDd6UR+JxDXNE9Kn1PgxMGEgGGQAp1wvaAmr0C3z2G6F0EUTOFFflORj++uIDau1IJyOW/3gnh8dv5BgBZuGcDzux7VW48/Gj9QbAG605NDvpbZwlvYLMvNlB63CNHzMKvat2pPhVSjGjx/O4BN2dG4VZlDG0I7V6lqQnpS1drnyGrvxlbvKwQUNHRMxmEBsfQtQbGe74p2m8hllHZHGxcd8vdBRQ5maTZ4MmiG+IcgKLEpEgfvLb3LU9g6jxCdwBfM0gC6xDcMbEd9ZfmE2k4IxKNuqzyQv75ifBalDbCMgEjhjFl4RTWSbhRb/VmBorYZoRUnPNwlk61wYGHbY0QiPC2R/wtNlDsvYnFpj5VAs7zN5/qpW91tm2WoXv1EpDFAgYReZHe9GAhGqPXA+eUGEwcQhWYpaOHJKC295JwYvmrxKErtGUVolwY1ByV9G+ysFEQuYwq5+ld8sCC2BEc23bfvFKcVX8Zovo9vggRjXieiPjP/GaBoFe7YgCdkCBdWs5r9OzC9DbxvkGE7B+eBp5WyC6mg0qbaFMzgmcoSpMxvbNCLC5lrI3bDfh9Q4qKi7d3LnfMKfx84HJ2DlFGevkCOSbgPZ7/C3Y/2eHciV5xilVqrvqABV3dZQYukhP9sBee2CZu8Awo=",
          "optionA": "Familial Hypophosphatemia",
          "optionB": "Anti-epileptic drug induced",
          "optionC": "Vitamin D deficiency",
          "optionD": "Hereditary Vitamin D dependency",
          "correctAnswer": "A",
          "explanation":
              "<tbody><tr><td><div class=\"greenText\" style=\"font-size: 75%; padding-top: 10px\">SOLUTION</div></td><td style=\"width: 100px; font-size: 50%; text-align: right; padding-top: 10px\"></td></tr><tr><td colspan=\"2\"><div class><p><strong>Causes of hypophosphatemia</strong>:</p>\n<ul class=\"ulClass\">\n<li class=\"liClass\">PTH dependent :1.Primary hyperparathyroidism</li>\n</ul>\n<p>2.Secondary hyperparathyroidism A) Vit D deficiency(primary -responsive to Vit D /Secondary -not responsive)</p>\n<p>B)Calcium starvation /Malabsorption</p>\n<p>C) Batters syndrome</p>\n<ul class=\"ulClass\">\n<li class=\"liClass\">PTH/PTHrp Independent :1.Excess FGR</li>\n</ul>\n<p>2. Intrinsic renal disease</p></div></td></tr><tr><td colspan=\"2\"></td></tr></tbody>",
          "extractedFrom": "AIIMS June 2020",
          "program": {
            "name": "MBBS",
            "id": "6157bfadac6c010012ce00f9"
          },
          "section": {
            "name": "Medicine",
            "id": "6157eb2fac6c010012ce0349"
          },
          "chapter": {
            "name": "Uncategorized",
            "id": "6159d114e84d9d0012759cd3"
          },
          "year": 2020,
          "createdAt": "2021-08-29T09:55:04.549Z",
          "createdBy": "612b5694d025f0658b98c6fa",
          "id": "615c5c6b4318e38d7b3c759e"
        }
      }
    ],
    "totalQuestions": 10,
    "createdAt": "2021-12-16T17:04:33.956Z",
    "updatedAt": "2021-12-16T17:04:33.956Z",
    "id": "61bb71a17c63a40011223467"
  },
  "totalQuestions": 10
};
