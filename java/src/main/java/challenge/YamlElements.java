package challenge;

import org.yaml.snakeyaml.Yaml;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Map;


// Loading Yaml file from resources/mobile_elements.yml and returning as Map
public class YamlElements {
    private Yaml yaml;
    private InputStream inputStream;
    private Map<String, String> ymlElements;
    private File file = new File("../resources/mobile_elements.yml");
    private String ymlPath = file.getAbsolutePath();

    public YamlElements() throws FileNotFoundException {
        yaml = new Yaml();
        inputStream = new FileInputStream(new File(ymlPath));
        ymlElements = yaml.load(inputStream);
    }

    public Map<String,String> getYmlElements(){
        return ymlElements;
    }

}
