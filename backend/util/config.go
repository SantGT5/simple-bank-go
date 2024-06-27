package util

import "github.com/spf13/viper"

// Config stores all configuration of the application
// The values are read vy viper from a config file or env variables
type Config struct {
	PostgresUrl string `mapstructure:"POSTGRES_URL"`
	BackendPort string `mapstructure:"BACKEND_PORT"`
}

func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName("app") // app.env
	viper.SetConfigType("env") // json, xml

	viper.AutomaticEnv()

	err = viper.ReadInConfig()

	if err != nil {
		return
	}

	err = viper.Unmarshal(&config)

	return
}

// Usage, example:
//
// config, err = util.LoadConfig("path/to/.env")

// if err != nil {
// 	log.Fatal("cant load config: ", err)
// }

// config.PostgresUrl
// config.BackendPort
