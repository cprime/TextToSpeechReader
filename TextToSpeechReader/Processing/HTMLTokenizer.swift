//
//  HTMLTokenizer.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/26/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

class HTMLTokenizer: NSObject, NSXMLParserDelegate {

    func parseHTMLString(HTMLString: String) {
        var mutableHTMLString: NSString = HTMLString;

        var regex1 = NSRegularExpression(pattern: "<a.*</a>", options: .CaseInsensitive, error: nil)
        while let result = regex1!.firstMatchInString(mutableHTMLString as String, options: NSMatchingOptions.allZeros, range: NSRange(location: 0, length: mutableHTMLString.length)) {
            var matchingRange = result.rangeAtIndex(0)
            if (matchingRange.location != NSNotFound) {
                mutableHTMLString = mutableHTMLString.stringByReplacingCharactersInRange(result.rangeAtIndex(0), withString: "")
            } else {
                break;
            }
        }

        var regex2 = NSRegularExpression(pattern: "</?br/?>", options: .CaseInsensitive, error: nil)
        while let result = regex2!.firstMatchInString(mutableHTMLString as String, options: NSMatchingOptions.allZeros, range: NSRange(location: 0, length: mutableHTMLString.length)) {
            var matchingRange = result.rangeAtIndex(0)
            if (matchingRange.location != NSNotFound) {
                mutableHTMLString = mutableHTMLString.stringByReplacingCharactersInRange(result.rangeAtIndex(0), withString: "\n")
            } else {
                break;
            }
        }

        var parser = NSXMLParser(data: mutableHTMLString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
        parser.delegate = self;
        parser.shouldResolveExternalEntities = false;
        var success = parser.parse()
    }

    //Mark: NSXMLParserDelegate

    func parserDidStartDocument(parser: NSXMLParser) {
        println(__FUNCTION__)
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        println(__FUNCTION__)
    }

    func parser(parser: NSXMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        println("\(__FUNCTION__) \(name) \(publicID) \(systemID)")
    }

    func parser(parser: NSXMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        println("\(__FUNCTION__) \(name) \(publicID) \(systemID) \(notationName)")
    }

    func parser(parser: NSXMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        println("\(__FUNCTION__) \(attributeName) \(elementName) \(type) \(defaultValue)")
    }

    func parser(parser: NSXMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        println("\(__FUNCTION__) \(elementName) \(model)")
    }

    func parser(parser: NSXMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        println("\(__FUNCTION__) \(name) \(value)")
    }

    func parser(parser: NSXMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        println("\(__FUNCTION__) \(name) \(publicID) \(systemID)")
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        println("\(__FUNCTION__) \(elementName) \(namespaceURI) \(qName) \(attributeDict)")
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        println("\(__FUNCTION__) \(elementName) \(namespaceURI) \(qName)")
    }

    func parser(parser: NSXMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        println("\(__FUNCTION__) \(prefix) \(namespaceURI)")
    }

    func parser(parser: NSXMLParser, didEndMappingPrefix prefix: String) {
        println("\(__FUNCTION__) \(prefix)")
    }

    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        println("\(__FUNCTION__) \(string)")
    }

    func parser(parser: NSXMLParser, foundIgnorableWhitespace whitespaceString: String) {
        println("\(__FUNCTION__) \(whitespaceString)")
    }

    func parser(parser: NSXMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        println("\(__FUNCTION__) \(target) \(data)")
    }

    func parser(parser: NSXMLParser, foundComment comment: String?) {
        println("\(__FUNCTION__) \(comment)")
    }

    func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
        println("\(__FUNCTION__) \(CDATABlock)")
    }

    func parser(parser: NSXMLParser, resolveExternalEntityName name: String, systemID: String?) -> NSData? {
        println("\(__FUNCTION__) \(name) \(systemID)")
        return nil
    }

    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println("\(__FUNCTION__) \(parseError)")
    }

    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        println("\(__FUNCTION__) \(validationError)")
    }
}
