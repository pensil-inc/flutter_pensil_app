class StudentModel{
  final String id;
  final String name;
  final String contact;
  final String avatar;

  StudentModel({this.id, this.name, this.contact, this.avatar});

  static List<StudentModel> dummyList(){
    return [
      StudentModel(
        name:"Arun Das",
        contact: "9835875364"
      ),
      StudentModel(
        name:"Shipra Kas",
        contact: "9835875364"
      ),
      StudentModel(
        name:"Rohan KAsjhyap",
        contact: "9876384736"
      ),
      StudentModel(
        name:"Abhay Prakash GAutam",
        contact: "9836253746"
      ),
      StudentModel(
        name:"Sanjay",
        contact: "8937463546"
      ),
    ];
  }
}