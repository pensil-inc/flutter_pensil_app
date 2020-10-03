// Import package
import 'package:contacts_service/contacts_service.dart';

class ContactService {
  static Future<List<Contact>> getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: true);
    return contacts.toList();
  }
}
