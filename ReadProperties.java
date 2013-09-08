public class ReadProperties
{
  public static void main(String[] args)
  {
    if (args.length == 0) System.exit(1);
    String property = System.getProperty(args[0]);
    if (property == null) System.exit(2);
    System.out.println(property);
  }
}
