package data.provider;

public class GenerateDataReal {

	public static String getEmail() {
		String email = "Ahmad";
		String provider = "@tek.us";
		int randomNumber = (int) (Math.random() * 10000);
		String autoEmail = email + randomNumber + provider;
		return autoEmail;

	}

	public static String getPlate() {
		String alphabet = "KBL";
		int randomNumber = (int) (Math.random() * 10000);
		String sign = "-";
		String licensePlate = alphabet + sign + randomNumber;

		return licensePlate;
	}

	public static String getPhone() {
		int code = 206;
		int first = (int) (Math.random() * 900);
		int second = (int) (Math.random() * 9000);
		String sign = "-";
		String phoneNumber = code + sign + first + sign + second;
		return phoneNumber;

	}
}
