*Open DICOM_web_ VNA*

# Plan

ODW VNA
1.	Read SOP Instance

1.	Validate w/ report

1.	Accept goto 4 reject goto 6

1.	Add/AddIfAbsent to:
    
    a.	Uid: Patient Entity
        i.	DICOM -> RDS
        ii.	MINT -> Series Dataset
    b.	Uid: Study Entity
        i.	DICOM -> RDS
        ii.	MINT -> Series Dataset
    c.	Uid: Series
        i.	DICOM -> RDS
        ii.	MINT -> Series Dataset
    d.	Uid: Instance
        i.	DICOM -> RDS
        ii.	MINT -> Series Dataset
    e.	Patient ID: Patient Uid
    
1.	Patient UID: List<Studies>
1.	Store Instance
    a.	As SOP Instance
    b.	As Multipart Series
    c.	As Mint Study
1.	Reject Instance or separate to 
