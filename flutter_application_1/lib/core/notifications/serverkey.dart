import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> serverToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
  "type": "service_account",
  "project_id": "blogmessage",
  "private_key_id": "4d554ddfe953b22b8fdadaf1a36842d2b87f8743",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQChl9w249djDlx3\ndK6usJSffDcTsB++lsWM8xLSFcnoBJ0TOi6Qo6U26P9bSCJI3gaz3ay9pEbgfswF\nRLThgkGvFmXHvWxZid6q3agvGPuhwZe/WyH3AU92cc+zrjQSz//xQNK4L1bcKHhV\nULZ5tvbkPpjpXNqGPg2b/HGHDbPIpoqTkQNuJUlm1/xI3wIby8Xl4JpkKZlIn1g3\nu/QMoXpGDT4dNhxDmtjT/41D+t2MN8lxvhMmBgWmooxzAM4wZKu7SV22gBMeUd1t\nEy6tQ/7jyrQj89Ga9L8UbpA50uHcmIYRtk978SEXzXxUjA6P4X9BTBsZn2AGRcpu\nIV9jI6wNAgMBAAECggEAMkG3ORESd1nLk1FkVKtRheqNfJ+Nt+pPZX9hzpn9Mh5h\nNc4mFlD2/MVpSdv84bm/zuf2JgL2EjMNQ+Qy92HaCNjH7d+xV4WkDXMjsAYumIfL\nqLVwslAjhRxvcxwOUP2ExeUZxDPg6Vbi2fHg1qj7T1BSoV2CDzc0Z1uTeWPfEtuO\nRVcAQFAoQOVemOyPr7S5k2bvccw7KHx7cNGuCJstOWx+mPXXB2W35LIbJ9mqPNuI\nfCWi9D0OCsHmIzt6iIY987laZili6ViGsBVj6hLrDvMwP+mjvYISALS6tTBz+oDr\ngALfAwPXLwpvf0CU4+R2Ti+VgsXw+wb1wtGvGXAS5wKBgQDYImMoW6x5NX4x4Kkg\n5xsc9Oh7rdeSWrsNPpIhtS5JeJAexE7LNtg+gA65RWzP8iF7lGfEBkIQcN6N2apl\nZ3msCtqDSkF+PHlT9gf36G9XGQz32h+nkIsqfpRwZs+pK7TyLP/9wzgoER2tRdyH\nnEOyfobgacOJTpKbX7Fb0Y9nSwKBgQC/ZhqwOHD7PAmfH1FVgy8CBrw2MJZ6ftez\n3NVPA0ciDMmRPxAF5TTOLpzv09DwcBI7APlaT2X7YRXHaNrzEXDnw2HFSNW2cGZ5\ni0oJvhHAOoubWvfOl0kTVdgsHw9jyL9hXcCmPOQgLsnmvIsqLdU5RoyWoF3pOyn+\n77K573LrBwKBgAlbK7myhjvVAfp8xDWFa5oMTAgWlW9jeBdxrvfAlRlfG7YJP3Py\nktfZyUlh5Pz3eVWVLgzBTJjTmf6//m1XVmAJND5ct4sUaRgmXV/w8ujtT69nBNnH\nGw8i3aAkAzdKihG1uvssOUEaxJMcpBhGvnN6oLIUQf+upBAPy2izIKcTAoGBAJBS\nJGOmW4MFlVe33LN3NJX5kCfoYT9Cr9F+/hUTKqsBK2hrPeDEIRorSckJVe5HA2gc\nZulzHzn6zdpMNXS9PP51dB63ufZUMOELZ6uK94WUX7qoUF0l9EMxIsy6KveZ4r0/\nXUm8dmPSBAoJN4J5huMmUFIv4EBCjXsfMQxFAsk3AoGBAL5NnL5Sv8x3bTdDXbCZ\npfr1uT58/Qy1UactbIWcXLYEM777jhC+arNFuy0QDDBifXAUl/aXqbOvLD+mPkg1\n72+Ot7pT6Ka3GWWzcJKyT5eVxXoavDnKX0Q3ZSV0U04esK0zZP/DFh7VLg7QxYLP\npNA2Nm7W+BS3pB/odv5aiY7S\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@blogmessage.iam.gserviceaccount.com",
  "client_id": "104796753757275748410",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40blogmessage.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}