const { format } = require("date-fns");
const { v4: uuid } = require("uuid");
const fs = require("fs");
const fsPromise = require("fs").promises;
const path = require("path");

const logEvents = async (message: any, logFileName: any) => {
  const dateTime = `${format(new Date(), "yyyyMMdd\tHH:mm:ss")}`;
  const logItem = `${dateTime}\t${uuid()}\t${message}\n`;
  try {
    if (!fs.existsSync(path.join(__dirname, "..", "logs"))) {
      await fsPromise.mkdir(path.join(__dirname, "..", "logs"));
    }
    await fsPromise.appendFile(
        path.join(__dirname, "..", "logs", logFileName),
        logItem
      );
  } catch (error) {
    console.log(error);
  }
};

const logger = (req: { method: any; url: any; headers: { origin: any; }; path: any; },res: any,next: () => void)=>{
    logEvents(`${req.method}\t${req.url}\t${req.headers.origin}`,'reqLog.log');
    console.log(`${req.method} ${req.path}`);
    next();
}

module.exports = {logEvents, logger};
